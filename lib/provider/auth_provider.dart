// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agritool/models/firebase/user_model.dart';
import 'package:agritool/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/screens/otp_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // signin using otp
  void signInWithPhone(
      BuildContext context, String phoneNumber, VoidCallback startTimer) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          showSnackBar(context, error.message.toString());
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          startTimer();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                forceResendingToken: forceResendingToken,
                startTimer: startTimer,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 120),
        forceResendingToken: null,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

//resend otp
  void resendVerificationCode(String phoneNumber, String verificationId,
      BuildContext context, VoidCallback startTimer) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          showSnackBar(context, error.message.toString());
          throw Exception(error.message);
        },
        codeSent: (newVerificationId, forceResendingToken) {
          // Update the verificationId with the new one
          verificationId = newVerificationId;

          startTimer();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                forceResendingToken: forceResendingToken,
                startTimer: startTimer,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 120),
        forceResendingToken: null,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // User verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERATIONS
//user database
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      // ignore: avoid_print
      print("USER EXISTS");
      return true;
    } else {
      // ignore: avoid_print
      print("NEW USER");
      return false;
    }
  }

//user save to firebase
  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    // required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      // await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
      // userModel.profilePic = value;
      userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      // });
      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

// user data
  void updateUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    {
      _isLoading = true;
      notifyListeners();
      try {
        // uploading image to firebase storage.
        // await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        // userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
        // });
        _userModel = userModel;

        // uploading to database
        await _firebaseFirestore
            .collection("users")
            .doc(_uid)
            .set(userModel.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.message.toString());
        _isLoading = false;
        notifyListeners();
      }
    }
  }

//user storage
  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//user data get
  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        gender: snapshot['gender'],
        name: snapshot['name'],

        // email: snapshot['email'],
        state: snapshot['state'],
        pincode: snapshot['pincode'],
        createdAt: snapshot['createdAt'],
        age: snapshot['age'],
        uid: snapshot['uid'],
        district: snapshot['district'],
        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = userModel.uid;
    });
  }

  // STORING DATA LOCALLY

  //user data storing
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

//sp user data get
  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

// user signout
  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  // //** feedback storing in firestore */

  // Future<void> addFeedback(
  //     String userId, String message, BuildContext context) async {
  //   try {
  //     final timestamp = DateTime.now();

  //     await _feedbackCollection.add({
  //       'userId': userId,
  //       'message': message,
  //       'timestamp': timestamp,
  //     });

  //     // Notify listeners that feedback has been added successfully
  //     notifyListeners();
  //   } catch (error) {
  //     // Handle any errors that occur during the process
  //     showSnackBar(context, error.toString());
  //     throw Exception('Failed to add feedback.');
  //   }
  // }

  // my account details add

  Future<void> updateUserDetails({
    required BuildContext context,
    required String name,
    required String address,
    required String state,
    required String gender,
    required String email,
    required String age,
    required String country,
  }) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    userRef.update({
      'age': age,
      'state': state,
      'gender': gender,
      'country': country,
      'address': address,
      'email': email,
      'name': name
    }).then((value) => Navigator.pop(context));
  }
}
