import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;

  CustomSnackBar({this.message});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        final snackBar = SnackBar(
          duration: Duration(seconds: 3),
          content: Text(message),
          action: SnackBarAction(
            label: 'Clear',
            onPressed: () {},
          ),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Text('Show SnackBar'),
    );
  }
}