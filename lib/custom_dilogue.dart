import 'package:flutter/material.dart';

class CustomDilogue extends StatelessWidget {

  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDilogue(this.title,this.content,this.callback,
      [this.actionText = "Reset"]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
      onPressed: callback,
      child: Text(actionText),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
    )
      ],
    );
  }
}
