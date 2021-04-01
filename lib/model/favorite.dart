import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  Favorite(DocumentSnapshot doc) {
    documentId = doc.id;
    picDocumentId = doc['picDocumentId'];
  }

  String documentId = '';
  String picDocumentId = '';
}
