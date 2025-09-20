import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) {
    throw Exception("Google Sign-In aborted");
  }

  // Get Google authentication details
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Sign in with Firebase
  final userCredential = await FirebaseAuth.instance.signInWithCredential(
    credential,
  );

  // Save user info to Firestore if first time login
  final userDoc = FirebaseFirestore.instance
      .collection("users")
      .doc(userCredential.user!.uid);

  if (!(await userDoc.get()).exists) {
    await userDoc.set({
      "name": userCredential.user!.displayName,
      "email": userCredential.user!.email,
      "createdAt": DateTime.now(),
    });
  }

  return userCredential;
}

Future<void> signOutFromGoogle() async {
  await GoogleSignIn().signOut(); // Sign out from Google
  await FirebaseAuth.instance.signOut(); // Sign out from Firebase
}
