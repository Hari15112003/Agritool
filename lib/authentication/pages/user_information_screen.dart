import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/models/firebase/user_model.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/main_page.dart';
import '../../custom/custom_button.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final pincodeController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    stateController.dispose();
    districtController.dispose();
    pincodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
  
        Provider.of<AuthProvider>(context, listen: true).isLoading;
           CustomSizeData size = CustomSizeData.from(context: context);
    double width = size.width;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            //name field
                            textField(
                                hintText: 'Enter your name',
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLine: 1,
                                controller: nameController),
                            //email
                            textField(
                                hintText: 'Enter the email-id',
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxLine: 1,
                                controller: emailController),
                            //about
                            textField(
                                hintText: 'Enter Your age',
                                icon: Icons.edit_document,
                                inputType: TextInputType.number,
                                maxLine: 2,
                                controller: ageController),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: width * 0.90,
                        child: CustomButton(
                          text: 'Continue',
                          onPressed: () {
                            storeData();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textField(
      {required String hintText,
      required IconData icon,
      required inputType,
      required int maxLine,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        keyboardType: inputType,
        controller: controller,
        maxLines: maxLine,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 216, 210, 217)),
            child: Icon(
              icon,
              size: 20,
              color: Colors.purple,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  //store your data
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      gender: '',
      state: stateController.text.trim(),
      district: districtController.text.trim(),
      pincode: pincodeController.text.trim(),
      name: nameController.text.trim(),
      // email: emailController.text.trim(),
      age: ageController.text.trim(),
      // profilePic: '',
      createdAt: '',
      phoneNumber: '',
      uid: '',
    );
    ap.saveUserDataToFirebase(
      context: context,
      userModel: userModel,
      // profilePic: image!,
      onSuccess: () {
        // once data iys saved  we store locally
        ap.saveUserDataToSP().then(
          (value) {
            ap.setSignIn().then(
                  (value) => Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                      (route) => false),
                );
          },
        );
      },
    );
  }
}


// 2:14:35