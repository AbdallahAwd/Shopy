import 'package:bloc/bloc.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop/layout/layout.dart';
import 'package:shop/modules/log_in/reset_password.dart';
import 'package:shop/shared/Cubit/logIn/login_states.dart';
import 'package:shop/shared/compnents/component.dart';
import 'package:shop/shared/networking/lacal/cache_helper.dart';

class LogInCubit extends Cubit <LoginStates> {
  LogInCubit() : super(initialState());

  static LogInCubit get(context) => BlocProvider.of(context);

  bool isAppear = true;
  IconData eyeIcon = Icons.visibility;

  void changeEye() {
    isAppear = !isAppear;
    eyeIcon = isAppear ? Icons.visibility : Icons.visibility_off_rounded;
    emit(ChangeEye());
  }

  UserCredential userCredential;
  var user = FirebaseAuth.instance.currentUser;
  void registerAuth({
    @required String email,
    @required String password,
    @required String name,
    @required context,
  }) async
  {
    emit(RegisterLoadingState());
    try {
      userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value)
      {
        emit(RegisterSuccessState());
        CacheHelper.saveData(key: 'uId', value: user.uid).then((value)
        {
          navigateTo(context, ResetPassword());
        });
        return null;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackBar(context, text: 'The password provided is too weak.' , color: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        snackBar(context, text: 'The account already exists for that email.' , color: Colors.red);
      }
    } catch (e) {
      // print(e);
    }
  }

  void logInAuth({
    @required String email,
    @required String password,
    context
  }) async
  {
    emit(LogInLoadingState());
    try {
      emit(LogInSuccessState());
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value)
      {
       CacheHelper.saveData(key: 'uId', value: user.uid).then((value) {
         navigateAnd(context, MyHomePage());
       });
        return null;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackBar(context, text: 'No user found for that email.', color: Colors.red) ;
        //print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        snackBar(context, text: 'Wrong password provided for that user.', color: Colors.red);
        //print('Wrong password provided for that user.');
      }
    }
  }

  void resetPassword({
  @required email,
}) async
  {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    emit(SendRepassword());
  }
  void emailVerification() async
  {
    User user = FirebaseAuth.instance.currentUser;

    if (user!= null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
  var emailAuth =  EmailAuth(
    sessionName: "Social App",
  );

  void sendEmail(String email) async {
    emailAuth.sessionName = 'Social App';
    var res = await emailAuth.sendOtp(recipientMail: email);
    if (res) {
      emit(OTBSendSuccessState());
    } else {
      emit(OTBSendErrorState());
    }
  }

  void verifyOTB(email, userOtp)
  {
    var res =  emailAuth.validateOtp(recipientMail: email, userOtp: userOtp);
    if (res) {
      emit(OTBVerifySuccessState());
    } else {
      emit(OTBVerifyErrorState());
    }
  }


  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _userPicker;

  Future googleLogin() async
  {
    // Trigger the authentication flow
    final  googleUser = await googleSignIn.signIn();

    if(googleUser == null) return;
    _userPicker = googleUser;
    final  googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
     FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      emit(GoogleSignInSuccess());
    });

  }

  Future logOut() async
  {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}