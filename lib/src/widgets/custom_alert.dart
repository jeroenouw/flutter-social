import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  @required final String title;
  @required final String content;

  @override
  _CustomAlertState createState() => _CustomAlertState();

  CustomAlert({this.title, this.content});
}

class _CustomAlertState extends State<CustomAlert> {
  String _title = 'Default title';
  String _content = 'Default content';

  @override
  Widget build(BuildContext context) {
    _setAlertDetails();

    return AlertDialog(
      title: Text(_title),
      content: Text(_content),
    );
  }

  void _setAlertDetails() {
    setState(() {
      _title = widget.title;
      _content = widget.content;
    });
  }
}
