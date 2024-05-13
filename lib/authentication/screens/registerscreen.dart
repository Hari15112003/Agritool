import 'dart:async';
import 'package:agritool/const/image_const.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:agritool/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneContoller = TextEditingController();

  Country selectedcountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
  );

  int _timerDuration = 120; // Duration in seconds for the timer
  bool _timerActive = false; // Indicates whether the timer is currently active
  Timer? _resendTimer; // Timer object for the countdown
  void startTimer() {
    setState(() {
      _timerActive = true; // Set the timer as active
      _timerDuration = 120; // Reset the timer duration
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--; // Decrease the remaining time
        } else {
          stopTimer(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      _timerActive = false; // Set the timer as inactive
    });
    _resendTimer?.cancel(); // Cancel the timer
  }

  @override
  void dispose() {
    stopTimer(); // Stop the timer only if it's active

    super.dispose();
  }

  void handleButtonClick() {
    if (_timerActive) {
      stopTimer(); // Stop the timer if it's active
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);

    double height = size.height;
    double width = size.width;

    phoneContoller.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneContoller.text.length));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: [
              Container(
                height: height * 0.3,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.purple.shade50),
                child: Image.asset(
                  ImageConst.registerImage,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomText(
                text: "Register",
                fontSize: size.largetext,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: height * 0.012,
              ),
              CustomText(
                text:
                    "Add your phone number , we'll send you a verification code",
                fontSize: size.mediumtext,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                  ],
                  style: TextStyle(
                    fontSize: size.mediumtext,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        phoneContoller.text = value;
                      },
                    );
                  },
                  cursorColor: Colors.purple,
                  controller: phoneContoller,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      hintStyle: TextStyle(
                        fontSize: size.mediumtext,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey.shade600,
                      ),
                      hintText: 'Enter phone number',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                        ),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(13.0),
                        child: InkWell(
                          child: CustomText(
                            text:
                                "${selectedcountry.flagEmoji} + ${selectedcountry.phoneCode}",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () {
                            showCountryPicker(
                              countryListTheme: CountryListThemeData(
                                inputDecoration: InputDecoration(
                                  prefixIcon: const CustomIcon(
                                    icon: Icons.search,
                                    color: Colors.purple,
                                  ),
                                  hintText: 'Search',
                                  helperStyle:
                                      const TextStyle(color: Colors.black38),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.purple,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                                bottomSheetHeight: height - 350,
                              ),
                              context: context,
                              onSelect: (value) {
                                setState(
                                  () {
                                    selectedcountry = value;
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      suffixIcon: phoneContoller.text.length > 9
                          ? Container(
                              height: height * 0.009,
                              margin: EdgeInsets.all(
                                width * 0.029,
                              ),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: const CustomIcon(
                                icon: Icons.done,
                                color: Colors.white,
                              ),
                            )
                          : null),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      sendPhoneNumber();
                    },
                    text: 'Login',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneContoller.text.trim();
    // in +919791340230 format
    ap.signInWithPhone(
        context, "+${selectedcountry.phoneCode}$phoneNumber", stopTimer);
  }
}
