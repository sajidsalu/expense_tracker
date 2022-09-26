import 'package:expense_tracker/modules/home/home.dart';
import 'package:expense_tracker/services/Utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSignin = false;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSignin?
      const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ):
      OutlinedButton(onPressed: () async{
        setState(() {
          _isSignin=true;
        });
        print("sign in pressed");
        User? user = await Authentication.signInWithGoogle(context: context);
        print("user signed in $user");
        setState(() {
          _isSignin=false;
        });
        if(user!= null){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen())
          );
        }
      }, 
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/google-icon.png",height: 20,width: 20,),
                const Padding(padding: EdgeInsets.only(left: 10),
                child: Text('Sign in with Google',
                style: TextStyle(fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.w600),),)
              ],
            ),
          ) ),
      );
  }
}
