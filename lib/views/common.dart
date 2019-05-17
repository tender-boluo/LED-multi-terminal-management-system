import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'dart:ui';

class Common extends StatefulWidget {
  @override
  _Common createState() => new _Common();
}

class _Common extends State<Common> {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _width = mediaQuery.size.width;
  static double _height = mediaQuery.size.height;
  List<Widget> imageList = List();
  @override
  void initState() {
    imageList
      ..add(Image.network(
        'http://software-terminal.oss-cn-beijing.aliyuncs.com/B6E83C5081AD55903216BFD9784FB18B.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'http://software-terminal.oss-cn-beijing.aliyuncs.com/C7F1BE994882B9E7B777E2C9B78B56A5.jpg',
        fit: BoxFit.fill,
      ));
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
              itemCount: 2,
              autoplay: true,
              duration: 500,
            ),
          ),
    );
  }
}
