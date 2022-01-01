import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techknowlogy/models/talk_model.dart';

class FirebaseApi {
  static Future<String> createTalk(Talk talk) async {
    try {
      final talkDoc = FirebaseFirestore.instance.collection('talks').doc();

      talk.id = talkDoc.id;
      await talkDoc.set(talk.toJson());
      return talkDoc.id;
    } on Exception catch (e) {
      print(e);
      return 'error';
    }
  }
}
