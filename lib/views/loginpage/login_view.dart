import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legal_doc_simplifier/views/loginpage/google_button.dart';
import 'package:legal_doc_simplifier/views/loginpage/guest_button.dart';

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

const Color softPink = Color.fromARGB(255, 245, 185, 192);

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Unroll',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 32),
              const Center(
                child: Text(
                  'Create an account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text("Enter your email to sign up for this app"),
              ),
              const SizedBox(height: 24),
              const GoogleButton(),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 16,
                      endIndent: 8,
                    ),
                  ),
                  Text("OR"),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 8,
                      endIndent: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const GuestButton(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'By clicking continue, you agree to our ',
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: Colors.blue),
                      // TODO: Add gesture recognizer if needed
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
