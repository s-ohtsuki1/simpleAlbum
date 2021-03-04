import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  Book(DocumentSnapshot doc) {
    documentId = doc.documentID;
    title = doc['title'];
    imageUrl = doc['imageUrl'];
  }

  String documentId;
  String title;
  String imageUrl;
}
