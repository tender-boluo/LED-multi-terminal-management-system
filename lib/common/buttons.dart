import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  CommonButton({Key key, this.text, this.route}) : super(key: key);
  final String text;
  final String route;
  @override
  Widget build(BuildContext context) {
    return new Padding(padding: new EdgeInsets.fromLTRB(25, 0, 15, 0),
      child:
        new OutlineButton(
          onPressed: () { Navigator.of(context).pushNamed(route);},
          child: new Text(text),
          textColor: Colors.blue,
        )
    );
  }
}