// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agritool/community/community_model.dart';
import 'package:agritool/models/firebase/user_model.dart';
import 'package:agritool/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

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
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          showSnackBar(context: context, content: error.message.toString());
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
      showSnackBar(context: context, content: e.message.toString());
    }
  }

//resend otp
  void resendVerificationCode(String phoneNumber, String verificationId,
      BuildContext context, VoidCallback startTimer) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          showSnackBar(context: context, content: error.message.toString());
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
      showSnackBar(context: context, content: e.message.toString());
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

      User? user = (await firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERATIONS
//user database
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("users").doc(_uid).get();
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
      userModel.phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid = firebaseAuth.currentUser!.phoneNumber!;
      // });
      _userModel = userModel;

      // uploading to database
      await firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message.toString());
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
        userModel.phoneNumber = firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = firebaseAuth.currentUser!.phoneNumber!;
        // });
        _userModel = userModel;

        // uploading to database
        await firebaseFirestore
            .collection("users")
            .doc(_uid)
            .set(userModel.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      } on FirebaseAuthException catch (e) {
        showSnackBar(context: context, content: e.message.toString());
        _isLoading = false;
        notifyListeners();
      }
    }
  }

//user storage
  Future<String> storeFileToStorage(String ref, File file) async {
    try {
      UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }

//user data get
  Future getDataFromFirestore() async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
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
    await firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

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
        firebaseFirestore.collection("users").doc(userId);

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

  // COMMUNITY

  Future<void> addPostToFirestore(CommunityModel post) async {
    try {
      // Prepare the data to be added to Firestore
      Map<String, dynamic> postData = <String, dynamic>{
        'userId': post.userId,
        'name': post.name,
        'profilePic': post.profileImage,
        'post': <String, dynamic>{
          post.date: <String, dynamic>{
            'content': post.content,
            'heading': post.heading,
          }
        }
      };

      if (post.imageUrl != null && post.imageUrl!.isNotEmpty) {
        List<String> imageUrls =
            await Future.wait(post.imageUrl!.map((file) async {
          return await storeFileToStorage(
              '${post.userId}/images/${post.date}_${file.path.split('/').last}',
              file);
        }));

        if (imageUrls.isNotEmpty) {
          postData['post'][post.date]['imageUrl'] =
              FieldValue.arrayUnion(imageUrls);
        }
      }
      if (post.videoUrl != null && post.videoUrl!.isNotEmpty) {
        // Upload videos to Firebase Storage and get download URLs
        List<String> videoUrls =
            await Future.wait(post.videoUrl!.map((file) async {
          return await storeFileToStorage(
              '${post.userId}/videos/${post.date}_${file.path.split('/').last}',
              file);
        }));
        if (videoUrls.isNotEmpty) {
          postData['post'][post.date]['videoUrl'] =
              FieldValue.arrayUnion(videoUrls);
        }
      }
      if (post.subheading != null) {
        postData['post'][post.date]['subheading'] = post.subheading;
      }

      // Add the post data to Firestore
      await firebaseFirestore.collection('posts').doc(post.userId).set(
            postData,
            SetOptions(merge: true),
          );
      print('Post added to Firestore');
    } catch (e) {
      print('Error adding post to Firestore: $e');
    }
  }
}
