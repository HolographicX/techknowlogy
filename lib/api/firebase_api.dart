import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techknowlogy/models/news_model.dart';
import 'package:techknowlogy/models/talk_model.dart';

class FirebaseApi {
  static final _talksCollection =
      FirebaseFirestore.instance.collection('talks');
  static Future<String> createTalk(Talk talk) async {
    try {
      final talkDoc = _talksCollection.doc();

      talk.id = talkDoc.id;
      await talkDoc.set(talk.toJson());
      return talkDoc.id;
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }

  static Stream<QuerySnapshot> readTalks() =>
      _talksCollection.orderBy('date', descending: true).snapshots();

  static Future<String> updateTalk(Talk talk) async {
    try {
      final talkdoc = _talksCollection.doc(talk.id);
      await talkdoc.update(talk.toJson());
      return talkdoc.id;
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }

  static Future<String> deleteTalk(Talk talk) async {
    try {
      final talkdoc = _talksCollection.doc(talk.id);
      await talkdoc.delete();
      return "${talkdoc.id} deleted";
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }

  static final _newsCollection = FirebaseFirestore.instance.collection('news');

  static Future<String> createNews(News news) async {
    try {
      final newsDoc = _newsCollection.doc();

      news.id = newsDoc.id;
      await newsDoc.set(news.toJson());
      return newsDoc.id;
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }

  static Stream<QuerySnapshot> readNews() =>
      _newsCollection.orderBy('date', descending: true).snapshots();

  static Future<String> updateNews(News news) async {
    try {
      final newsdoc = _newsCollection.doc(news.id);
      await newsdoc.update(news.toJson());
      return newsdoc.id;
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }

  static Future<String> deleteNews(News news) async {
    try {
      final newsdoc = _newsCollection.doc(news.id);
      await newsdoc.delete();
      return "${newsdoc.id} deleted";
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }
}
