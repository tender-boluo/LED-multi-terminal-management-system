import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:terminal/common/buttons.dart';
import 'common.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _width = mediaQuery.size.width;
  static double _height = mediaQuery.size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            height: _height-128,
            width: _width,
            child: new Common()
          ),
          new Row(
            children: <Widget>[
              new CommonButton(text: '上传图片', route: '/insert'),
              new CommonButton(text: '常规设置', route: '/common'),
              new CommonButton(text: '媒体文件', route: '/media-file'),
              new CommonButton(text: '播放设置', route: '/setting'),
            ]
          ),
        ]
      )
    );
  }
}
