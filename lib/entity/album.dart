import 'package:cloud_firestore/cloud_firestore.dart';

class Album {
  Album(DocumentSnapshot doc) {
    documentId = doc.documentID;
    title = doc['title'];
    coment = doc['coment'];
    categoryId = doc['categoryId'];
    imageUrl = doc['imageUrl'];
    createdAt = doc['createdAt'];
  }

  String documentId;
  String title;
  String coment;
  int categoryId;
  String imageUrl;
  Timestamp createdAt;
  bool preIsFavorite = false;
}
