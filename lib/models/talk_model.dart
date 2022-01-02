import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class Utils {
  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }

  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps
              .map((json) => fromJson(json as Map<String, dynamic>))
              .toList();

          sink.add(objects);
        },
      );
}
