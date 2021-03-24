import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User(DocumentSnapshot doc) {
    documentId = doc.documentID;
    userId = doc['userId'];
    email = doc['email'];
  }

  String documentId;
  int userId;
  String email;
}
