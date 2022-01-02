import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techknowlogy/models/utils.dart';

class Talk {
  DateTime? date;
  String? title;
  String? keyInsights;
  String? bgHex;
  String? imglink;
  String? id;
  String? description;
  String? recordingUrl;
  Talk(
      {@required this.title,
      @required this.bgHex,
      @required this.imglink,
      @required this.date,
      @required this.recordingUrl,
      @required this.keyInsights,
      this.id,
      required this.description});
  static Talk fromJson(Map<String, dynamic> json) => Talk(
      recordingUrl: json['recordingUrl'],
      date: Utils.toDateTime(json['date']),
      title: json['title'],
      keyInsights: json['keyInsights'],
      bgHex: json['bgHex'],
      imglink: json['imglink'],
      id: json['id'],
      description: json['description']);
  Map<String, dynamic> toJson() => {
        'date': date!.toUtc(),
        'title': title,
        'keyInsights': keyInsights,
        'bgHex': bgHex,
        'imglink': imglink,
        'id': id,
        'description': description,
        'recordingUrl': recordingUrl
      };
}
