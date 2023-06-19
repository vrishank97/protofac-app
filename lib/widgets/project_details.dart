import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectRepository {
  final CollectionReference _projects = FirebaseFirestore.instance.collection('projects');

  Future<void> createProject(String projectName) {
    return _projects
        .add({
          'projectName': projectName,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        })
        .then((value) => print("Project Created"))
        .catchError((error) => print("Failed to create project: $error"));
  }

  Future<void> updateProject(String projectId, String projectName) {
    return _projects
        .doc(projectId)
        .update({
          'projectName': projectName,
          'updatedAt': FieldValue.serverTimestamp(),
        })
        .then((value) => print("Project Updated"))
        .catchError((error) => print("Failed to update project: $error"));
  }
}
