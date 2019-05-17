import 'package:flutter/material.dart';
import 'views/homepage.dart';
import 'views/common.dart';
import 'views/mediaFile.dart';
import 'views/setting.dart';
import 'views/insert.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(title: 'LED-terminal'),
        routes: <String, WidgetBuilder> {
          '/insert' : (BuildContext context) => new InsertImages(),
          '/common'  : (BuildContext context) => new Common(),
          '/media-file'    : (BuildContext context) => new MediaFile(),
          '/setting': (BuildContext context) => new Setting(),
        },
    );
  }
}