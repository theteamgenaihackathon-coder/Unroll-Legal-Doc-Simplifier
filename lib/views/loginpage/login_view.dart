import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/loginpage/google_button.dart';
import 'package:legal_doc_simplifier/views/loginpage/guest_button.dart';

const Color softPink = Color.fromARGB(255, 245, 185, 192);

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const Row dividerLine = Row(
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
    );

    const Text termsAndService = Text.rich(
      TextSpan(
        text: 'By clicking continue, you agree to our ',
        style: TextStyle(fontSize: 12),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(color: Colors.blue),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Unroll',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Text(
                'Create an account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Enter your email to sign up for this app",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const GoogleButton(),
              const SizedBox(height: 12),
              dividerLine,
              const SizedBox(height: 12),
              const GuestButton(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              termsAndService,
            ],
          ),
        ),
      ),
    );
  }
}
