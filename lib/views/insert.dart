import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import '../common/oss.dart';
import '../common/databaseHelper.dart';
import '../model/images.dart';

class InsertImages extends StatefulWidget {
  @override
  _InsertImagesState createState() => new _InsertImagesState();
}

class _InsertImagesState extends State<InsertImages> {

  var _imgPath;
  var _putFlag;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('上传图片'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _imageView(_imgPath),
              RaisedButton(
                onPressed: _takePhoto,
                child: Text("拍照"),
              ),
              RaisedButton(
                onPressed: _openGallery,
                child: Text("选择照片"),
              ),
              RaisedButton(
                onPressed: _putImage,
                child: Text("上传图片"),
              ),
            ],
          ),
        ));
  }

  Widget _imageView(imgPath) {
    if (imgPath == null && _putFlag != 1) {
      return Center(
        child: Text("请选择图片或拍照"),
      );
    } else if(imgPath == null && _putFlag == 1){
      return Center(
        child: Text("图片上传成功"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
  }

  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imgPath = image;
    });
  }

  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }

  _putImage() async {
    String policyBase64 = base64.encode(utf8.encode(
        '{"expiration": "2020-01-01T12:00:00.000Z","conditions": [["content-length-range", 0, 1048576000]]}'
    ));
    String signature = base64.encode(Hmac(sha1, utf8.encode(Oss().secret)).convert(
        utf8.encode(policyBase64)).bytes
    );
    Dio dio = new Dio();
    dio.options.responseType = ResponseType.plain;

    String fileName = (DateTime.now().millisecondsSinceEpoch/1000).ceil().toString()+".jpg";

    FormData data = new FormData.from({
      'Filename': fileName,
      'key' : fileName,
      'policy': policyBase64,
      'OSSAccessKeyId': Oss().key,
      'success_action_status' : '200', //让服务端返回200，不然，默认会返回204
      'signature': signature,
      'file': new UploadFileInfo(_imgPath, "imageFileName")
    });
    try {
      var db = DatabaseHelper();
      var image = Images(fileName);
      db.saveImage(image);
      await dio.post('https://software-terminal.oss-cn-beijing.aliyuncs.com/',data: data);
      setState(() {
        _imgPath = null;
        _putFlag = 1;
      });

    } on DioError catch(e) {
      print("图片上传失败");
    }
  }
}