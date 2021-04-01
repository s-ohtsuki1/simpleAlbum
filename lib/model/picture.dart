import 'package:cloud_firestore/cloud_firestore.dart';

class Picture {
  Picture(DocumentSnapshot doc) {
    documentId = doc.id;
    title = doc['title'];
    comment = doc['comment'];
    albumNo = doc['albumNo'];
    imageUrl = doc['imageUrl'];
    shotDate = doc['shotDate'];
    createdAt = doc['createdAt'];
  }

  String documentId = '';
  String title = '';
  String comment = '';
  int albumNo = 1;
  String imageUrl = '';
  Timestamp shotDate = Timestamp.now();
  Timestamp createdAt = Timestamp.now();
  bool preIsFavorite = false;
}
