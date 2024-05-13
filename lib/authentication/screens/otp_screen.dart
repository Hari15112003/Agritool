import 'dart:async';

import 'package:agritool/authentication/pages/user_information_screen.dart';
import 'package:agritool/const/image_const.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:agritool/custom/custom_button.dart';
import 'package:agritool/custom/custom_snackBar.dart';
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
    stopTimer(); // Stop the timer only if it's active

    super.dispose();
  }

  void handleButtonClick() {
    if (_timerActive) {
      stopTimer(); // Stop the timer if it's active
      // Dispose the timer if needed
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.04,
                    horizontal: width * 0.06,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const CustomIcon(icon: Icons.arrow_back),
                        ),
                      ),
                      Container(
                        height: height * 0.28,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.shade50,
                        ),
                        child: Image.asset(
                          ImageConst.otpImage,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      CustomText(
                        text: "Verification",
                        fontWeight: FontWeight.bold,
                        fontSize: size.largetext,
                      ),
                      SizedBox(height: height * 0.02),
                      const CustomText(
                        text: "Enter the OTP send to your phone number",
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: height * 0.03),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: width * 0.18,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.purple.shade200,
                            ),
                          ),
                          textStyle: TextStyle(
                            fontSize: size.mediumtext,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.05),
                      CustomText(
                        text: "Seconds Remaining $_timerDuration",
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.05,
                        child: CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(
                                  context: context,
                                  content: "Enter 6-Digit code");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const CustomText(
                        text: "Didn't receive any code?",
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      GestureDetector(
                        child: const CustomText(
                          text: "Resend New Code",
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                        onTap: () {
                          _timerDuration == 0
                              ? ap.resendVerificationCode(
                                  widget.phoneNumber,
                                  widget.verificationId,
                                  context,
                                  startTimer,
                                )
                              : showSnackBar(
                                  context: context,
                                  content:
                                      'Wait for sometime until the time is over');
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
                          (value) => ap.setSignIn().then((value) =>
                              context.pushAndRemoveUntil(const Home())),
                        ),
                  );
            } else {
              // new user
              context.pushAndRemoveUntil(const UserInformationScreen());
            }
          },
        );
      },
    );
  }
}
