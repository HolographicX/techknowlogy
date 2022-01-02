import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techknowlogy/models/talk_model.dart';

class FirebaseApi {
  static final _collection = FirebaseFirestore.instance.collection('talks');
  static Future<String> createTalk(Talk talk) async {
    try {
      final talkDoc = _collection.doc();

      talk.id = talkDoc.id;
      await talkDoc.set(talk.toJson());
      return talkDoc.id;
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }

  static Stream<QuerySnapshot> readTalks() =>
      _collection.orderBy('date', descending: true).snapshots();

  static Future<String> updateTalk(Talk talk) async {
    try {
      final talkdoc = _collection.doc(talk.id);
      await talkdoc.update(talk.toJson());
      return talkdoc.id;
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }
}
