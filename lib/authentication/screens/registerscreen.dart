import 'dart:async';
import 'package:agritool/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

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

// here error
  void stopTimer() {
    setState(() {
      _timerActive = false; // Set the timer as inactive
    });
    _resendTimer?.cancel(); // Cancel the timer
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
    }
    // Handle the button click event
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    var width = MediaQuery.of(context).size.width;
    //change the postion of text from l to r
    phoneContoller.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneContoller.text.length));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.purple.shade50),
                child: Image.asset('assets/images/image2.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height * 0.012,
            ),
            const Text(
              "Add your phone number , we'll send you a verification code",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(96, 24, 24, 24),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                ],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey.shade600),
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
                        child: Text(
                          "${selectedcountry.flagEmoji} + ${selectedcountry.phoneCode}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          showCountryPicker(
                            countryListTheme: CountryListThemeData(
                              inputDecoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
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
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : null),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () {
                    sendPhoneNumber();

                    // ignore: avoid_print
                    print(
                        "+${selectedcountry.phoneCode}${phoneContoller.text.trim()}");
                  },
                  text: 'Login',
                ),
              ),
            )
          ],
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
