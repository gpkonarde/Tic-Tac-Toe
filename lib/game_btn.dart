import 'package:flutter/material.dart';

class GameBtn{
  final id;
  String text;
  Color bg;
  bool enabled;

  GameBtn({this.id,this.text='',this.bg=Colors.grey, this.enabled=true});
}