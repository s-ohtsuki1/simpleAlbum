import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  Book(DocumentSnapshot doc) {
    documentId = doc.documentID;
    title = doc['title'];
  }

  String documentId;
  String title;
}
