import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class Utils {
  static DateTime toDateTime(Timestamp value) {
    print("yes");
    return value.toDate();
  }

  static String formatDate(DateTime datetime) {
    return DateFormat.yMMMMd('en_US').format(datetime);
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
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSuccessSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: cyanSuccessVarntLight,
    ));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showErrorSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: bittersweet,
    ));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showDefaultSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: bittersweet,
    ));
  }
}
