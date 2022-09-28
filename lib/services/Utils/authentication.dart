import 'package:expense_tracker/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;

class Authentication{



  static Future<FirebaseApp> initializeFirebase({
  required BuildContext context,
}) async
  {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen(),
       ),
      );
    }
    return firebaseApp;
  }

  static Future<void> signOut({
    required BuildContext context
}) async
  {
    final GoogleSignIn googleSignIn= GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }

  static Future<User?> signInWithGoogle({
    required BuildContext context
  })async
  {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    GoogleAuthProvider authProvider = GoogleAuthProvider();

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);
        print("user credentials ${userCredential.user}");
        user = userCredential.user;
        return user;
      } on FirebaseAuthException catch (e) {
        print("exception occured $e");
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content:
              'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content:
              'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      }
    }
  }

    static SnackBar customSnackBar({required String content}) {
      return SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          content,
          style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
        ),
      );
    }

  }