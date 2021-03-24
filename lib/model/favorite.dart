import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  Favorite(DocumentSnapshot doc) {
    documentId = doc.documentID;
    userId = doc['userId'];
    picDocumentId = doc['picDocumentId'];
  }

  String documentId;
  String picDocumentId;
  String userId;
}
