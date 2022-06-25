import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title;
  String description;

  Task({required this.title, required this.description});

  factory Task.fromDoc(DocumentSnapshot doc) {
    return Task(title: doc['title'], description: doc['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
