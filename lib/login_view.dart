import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/main.dart';

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
              Center(
                child: Text(
                  'App name',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: Text(
                  'Create an account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 16),

              Center(child: Text("Enter your email to sign up for this app")),
              SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: softPink,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 48),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // icon: Image.asset('assets/google_logo.png', height: 20),
                label: Text('Continue with Google'),
                onPressed: () {
                  // TODO: Handle Google Sign-In
                },
              ),
              SizedBox(height: 12),
              Center(child: Text('or')),
              SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  foregroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(Icons.person_outline),
                label: Text('Continue as guest'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text.rich(
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
