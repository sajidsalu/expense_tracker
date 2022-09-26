import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/modules/home/home.dart';
import 'package:expense_tracker/services/Utils/authentication.dart';
import 'package:expense_tracker/widgets/google_signin_button.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignIn =false;
  bool google =false;

  GlobalKey<FormState> _userLoginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Login",style: TextStyles.h5lightGrey,),
          ),
          FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Text("Error initializing Firebase");
                }else if(snapshot.connectionState == ConnectionState.done){
                  return GoogleSignInButton();
                }
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                   CustomColors.firebaseOrange,
                  ),
                );
              })

        ],
      ),
    );
  }
}
