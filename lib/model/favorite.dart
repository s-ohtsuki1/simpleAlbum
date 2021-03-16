import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  Favorite(DocumentSnapshot doc) {
    documentId = doc.documentID;
    userId = doc['userId'];
    picDocumentId = doc['picDocumentId'];
    isFavorite = doc['isFavorite'];
  }

  String documentId;
  String picDocumentId;
  int userId;
  bool isFavorite;
}
