// // ignore_for_file: use_build_context_synchronously

// import 'package:agritool/firebase/firebase_operations.dart';
// import 'package:agritool/utils/widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../provider/internet_provider.dart';

// class PhoneAuthScreen extends StatefulWidget {
//   const PhoneAuthScreen({super.key});

//   @override
//   State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
// }

// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   final formKey = GlobalKey<FormState>();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController otpCodeController = TextEditingController();
//   final ageController = TextEditingController();
//   final stateController = TextEditingController();
//   final districtController = TextEditingController();
//   final pincodeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             print("Log in");
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Image(
//                     image: AssetImage('assets/images/image2.png'),
//                     height: 50,
//                     width: 50),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "Phone Login",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Name cannot be empty";
//                     }
//                     return null;
//                   },
//                   controller: nameController,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.account_circle),
//                       hintText: "Adam Smith",
//                       hintStyle: TextStyle(color: Colors.grey[600]),
//                       errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.red)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.grey)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.grey))),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Email address cannot be empty";
//                     }
//                     return null;
//                   },
//                   controller: emailController,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.email),
//                       hintText: "abc@gmail.com",
//                       hintStyle: TextStyle(color: Colors.grey[600]),
//                       errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.red)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.grey)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.grey))),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Phone Number cannot be empty";
//                     }
//                     return null;
//                   },
//                   controller: phoneController,
//                   textInputAction: TextInputAction.done,
//                   decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.phone),
//                       hintText: "+1-1234567890",
//                       hintStyle: TextStyle(color: Colors.grey[600]),
//                       errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.red)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.grey)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.grey))),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     login(context, phoneController.text.trim());
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                   ),
//                   child: const Text("Register"),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future login(BuildContext context, String mobile) async {
//     final sp = context.read<FirebaseOperations>();
//     final ip = context.read<InternetProvider>();

//     await ip.checkInternetConnection();

//     if (ip.hasInternet == false) {
//       showSnackBar(
//         context: context,
//         content: "Check your internet connection",
//       );
//     } else {
//       if (formKey.currentState!.validate()) {
//         sp.firebaseAuth.verifyPhoneNumber(
//             phoneNumber: mobile,
//             verificationCompleted: (AuthCredential credential) async {
//               await FirebaseAuth.instance.signInWithCredential(credential);
//             },
//             verificationFailed: (FirebaseAuthException e) {
//               showSnackBar(
//                 context: context,
//                 content: e.toString(),
//               );
//             },
//             codeSent: (String verificationId, int? forceResendingToken) {
//               showDialog(
//                   barrierDismissible: false,
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text("Enter Code"),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           TextField(
//                             controller: otpCodeController,
//                             decoration: InputDecoration(
//                                 prefixIcon: const Icon(Icons.code),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide:
//                                         const BorderSide(color: Colors.red)),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey)),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey))),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           ElevatedButton(
//                             onPressed: () async {
//                               final code = otpCodeController.text.trim();
//                               AuthCredential authCredential =
//                                   PhoneAuthProvider.credential(
//                                       verificationId: verificationId,
//                                       smsCode: code);
//                               User user = (await FirebaseAuth.instance
//                                       .signInWithCredential(authCredential))
//                                   .user!;
//                               // save the values
//                               sp.phoneNumberUser(user, emailController.text,
//                                   nameController.text);
//                               // checking whether user exists,
//                               sp.checkUserExists().then((value) async {
//                                 if (value == true) {
//                                   // user exists
//                                   // await sp
//                                   //     .getUserDataFromFirestore(sp.uid)
//                                   //     .then((value) => sp
//                                   //         .saveDataToSharedPreferences()
//                                   //         .then((value) =>
//                                   //             sp.setSignIn().then((value) {
//                                   //               nextScreenReplace(context,
//                                   //                   const HomeScreen());
//                                   //             })));
//                                 } else {
//                                   // user does not exist
//                                   // await sp.saveDataToFirestore().then((value) =>
//                                   //     sp.saveDataToSharedPreferences().then(
//                                   //         (value) =>
//                                   //             sp.setSignIn().then((value) {
//                                   //               nextScreenReplace(context,
//                                   //                   const HomeScreen());
//                                   //             })));
//                                 }
//                               });
//                             },
//                             child: const Text("Confirm"),
//                           )
//                         ],
//                       ),
//                     );
//                   });
//             },
//             codeAutoRetrievalTimeout: (String verification) {});
//       }
//     }
//   }
// }
