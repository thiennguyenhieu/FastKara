import 'package:flutter/material.dart';

import '../../static/const_color.dart';

class PlaySongPage extends StatefulWidget {
  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: CommonColor.colorBackground,
        body: Container(
          margin: EdgeInsets.only(left: 10, top: 5, right: 10),
          height: MediaQuery.of(context).size.height / 2.2,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5))),
          child: Text(
            'Lyrics: \nThis is sample text',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ));
  }
}
