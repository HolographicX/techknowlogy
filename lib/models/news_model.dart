import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techknowlogy/models/utils.dart';

class News {
  DateTime? date;
  String? title;
  String? content;
  String? id;
  News(
      {@required this.title,
      @required this.content,
      this.id,
      required this.date});
  static News fromJson(Map<String, dynamic> json) => News(
      date: Utils.toDateTime(json['date']),
      title: json['title'],
      id: json['id'],
      content: json['content']);
  Map<String, dynamic> toJson() => {
        'date': date!.toUtc(),
        'title': title,
        'content': content,
        'id': id,
      };
}
