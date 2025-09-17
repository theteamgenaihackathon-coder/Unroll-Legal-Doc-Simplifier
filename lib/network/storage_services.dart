import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> uploadDocument(File file) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not signed in");

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = _storage.ref().child("documents/${user.uid}/$fileName.pdf");

    // Upload to Firebase Storage
    await ref.putFile(file);

    // Get file URL
    final url = await ref.getDownloadURL();

    // Save metadata in Firestore
    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("documents")
        .add({
      "url": url,
      "uploadedAt": DateTime.now(),
    });
  }
}