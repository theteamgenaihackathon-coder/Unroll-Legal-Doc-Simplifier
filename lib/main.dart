import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/login_view.dart';
import 'package:legal_doc_simplifier/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:legal_doc_simplifier/menu_popup.dart';

const Color ourRed = Color(0xFFC10547);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAuth.instance.signOut();

  //await GoogleSignIn().signOut();//to be replaced with the logout thing
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: const LoginView(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(200),
        leading: menuButton(),
        // actions: [accountButton()],
        title: Text(""),
        centerTitle: true,
        actions: [
          const SizedBox(width: 0), // spacing before the button
          Builder(
            builder: (context) => AccountButton(
              onProfile: () {
                print('Profile tapped');
              },
              onLogout: () async {
  try {
    await signOutFromGoogle(); // your helper method
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Logout failed: $e")),
    );
  }
},

            ),
          ),

          const SizedBox(width: 0), // spacing after the button
        ],
      ),

      body: const HomeBody(),
      backgroundColor: Colors.white,
    );
  }
}
