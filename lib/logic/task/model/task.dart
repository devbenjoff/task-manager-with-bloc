import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final String description;

  const Task({required this.title, required this.description});

  factory Task.fromDoc(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Task(title: doc['title'], description: doc['description']);
  }
}
