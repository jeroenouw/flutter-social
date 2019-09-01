import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlueAccent,
        child: Center(
          child: RaisedButton(
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('This is a custom snackbar'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Text('Show SnackBar'),
          ),
        ));
  }
}
