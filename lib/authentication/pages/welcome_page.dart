import 'package:agritool/const/image_const.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:agritool/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/registerscreen.dart';
import '../../home/main_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<AuthProvider>(context, listen: false);

    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConst.welcomeImage,
                height: height * 0.38,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomText(
                text: "Let's get started",
                fontSize: size.largetext,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: height * 0.026,
              ),
              CustomText(
                text: "Never a better time than now to start ",
                fontSize: size.mediumtext,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                child: CustomButton(
                  text: 'GetStarted',
                  onPressed: () async {
                    //if signed in -> home
                    // else register
                    //when true fetch the shared preference data

                    if (ref.isSignedIn == true) {
                      await ref.getDataFromSP().whenComplete(
                          () => context.pushReplacement(const Home()));
                    } else {
                      context.pushReplacement(const RegisterScreen());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
