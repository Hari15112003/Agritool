import 'dart:async';

import 'package:agritool/authentication/pages/user_information_screen.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:agritool/utils/custom_button.dart';
import 'package:agritool/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../home/main_page.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final int? forceResendingToken;
  final VoidCallback startTimer;
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.verificationId,
    this.forceResendingToken,
    required this.startTimer,
    required this.phoneNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  late bool _timerActive;
  late int _timerDuration;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _timerActive = true; // Set the timer as active
    _timerDuration = 120; // Set the initial timer duration
    startTimer();
  }

  void startTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      _timerActive = false; // Set the timer as inactive
    });
    _resendTimer?.cancel();
  }

  @override
  void dispose() {
    // if (_resendTimer != null && _timerActive) {
    stopTimer(); // Stop the timer only if it's active
    // }
    super.dispose();
  }

  void handleButtonClick() {
    if (_timerActive) {
      stopTimer(); // Stop the timer if it's active
      // Dispose the timer if needed
    } else {
      // ignore: avoid_print
      print("Timer problem");
    }
    // Handle the button click event
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.shade50,
                        ),
                        child: Image.asset(
                          "assets/images/image2.png",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.purple.shade200,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      Text("Seconds Remaining $_timerDuration"),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        child: const Text(
                          "Resend New Code",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        onTap: () {
                          _timerDuration == 0
                              ? ap.resendVerificationCode(
                                  widget.phoneNumber,
                                  widget.verificationId,
                                  context,
                                  startTimer,
                                )
                              : showSnackBar(context,
                                  'Wait for sometime until the time is over');
                          // ignore: avoid_print
                          print("Otp resended");
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // /*User Verify*/
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db

        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInformationScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
