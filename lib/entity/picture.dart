import 'package:cloud_firestore/cloud_firestore.dart';

class Picture {
  Picture(DocumentSnapshot doc) {
    documentId = doc.documentID;
    title = doc['title'];
    comment = doc['comment'];
    albumNo = doc['albumNo'];
    imageUrl = doc['imageUrl'];
    createdAt = doc['createdAt'];
  }

  String documentId;
  String title;
  String comment;
  int albumNo;
  String imageUrl;
  Timestamp createdAt;
  bool preIsFavorite = false;
}
