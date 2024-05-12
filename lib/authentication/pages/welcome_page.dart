
import 'package:agritool/provider/auth_provider.dart';
import 'package:agritool/utils/custom_button.dart';
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
    final ap =
        Provider.of<AuthProvider>(context, listen: false); //callinf provider
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/image1.png",
                height: height * 0.38,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let's get started",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.026,
              ),
              const Text(
                "Never a better time than now to start ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'GetStarted',
                  onPressed: () async {
                    //if signed in -> home
                    // else register
                    //when true fetch the shared preference data

                    if (ap.isSignedIn == true) {
                      await ap.getDataFromSP().whenComplete(
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                            ),
                          );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
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
