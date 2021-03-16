import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  Book(DocumentSnapshot doc) {
    documentId = doc.documentID;
    title = doc['title'];
    categoryId = doc['categoryId'];
    imageUrl = doc['imageUrl'];
    createdAt = doc['createdAt'];
  }

  String documentId;
  String title;
  int categoryId;
  String imageUrl;
  Timestamp createdAt;
}
