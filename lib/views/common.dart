import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:ui';

import '../common/databaseHelper.dart';

class Common extends StatefulWidget {
  @override
  _Common createState() => new _Common();
}

class _Common extends State<Common> {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _width = mediaQuery.size.width;
  static double _height = mediaQuery.size.height;
  List<Widget> imageList = List();
  List<Map<String, dynamic>> allImages = List();
  var db = DatabaseHelper();
  int cnt = 0;

  setData() async {
    cnt = await db.getCount();
  }
  @override
  void initState() {
    setData();
    for(int i = 0; i < allImages.length; i++){
      Map<String, dynamic> tmp = allImages[i];
      print(tmp['fileName']);
      imageList
        ..add(Image.network(
          'https://software-terminal.oss-cn-beijing.aliyuncs.com/'+ tmp['fileName'],
          fit: BoxFit.fill,
        ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          new Container(
            height: _height,
            width: _width,
            child: new Swiper(
              itemBuilder: (BuildContext context,int index){
                return imageList[index];
              },
              itemCount: cnt,
              autoplay: true,
              duration: 500,
            ),
          ),
    );
  }
}
