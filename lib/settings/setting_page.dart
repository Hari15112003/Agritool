import 'package:agritool/custom/custom_back_button.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/theme/provider/darktheme_provider.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController nameController = TextEditingController(text: 'Name');
  TextEditingController emailController = TextEditingController(text: 'Email');
  TextEditingController stateController = TextEditingController(text: "State");
  TextEditingController addressContoller =
      TextEditingController(text: 'Address');
  TextEditingController districtController =
      TextEditingController(text: "District");

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    stateController.dispose();
    addressContoller.dispose();
    districtController.dispose();
  }

  String countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en')},
    {
      'name': 'TAMIL',
      'locale': const Locale(
        'ta',
      )
    },
  ];

  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context, String languageSelected) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: CustomText(text: "chooselang".tr),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   languageSelected = locale[index]['name'];
                        // });
                        updatelanguage(locale[index]['locale']);
                      },
                      child: CustomText(
                        text: locale[index]['name'],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.blue,
                  );
                },
                itemCount: locale.length,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBackButton(
              text: 'My Account',
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 141, 136, 122),
                          shape: BoxShape.circle),
                      child: CustomIconButton(
                          onPressed: () {
                            themeChange.setDarkTheme =
                                !themeChange.getDarkTheme;
                          },
                          icon: CustomIcon(
                            icon: themeChange.getDarkTheme == true
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: Colors.white,
                          ))),
                )),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  children: [
                    InkWell(
                        onTap: () {
                          // selectedImage();
                        },
                        child:
                            // image == null
                            //     ?
                            const CircleAvatar(
                          backgroundColor: Color.fromARGB(95, 100, 68, 68),
                          radius: 50,
                          child: CustomIcon(
                            icon: Icons.account_circle,
                            size: 50,
                            color: Colors.white,
                          ),
                        )
                        // : CircleAvatar(
                        //     backgroundImage: FileImage(image!),
                        //     radius: 50,
                        //   ),
                        ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                shape: BoxShape.circle,
                                color:
                                    const Color.fromARGB(255, 244, 197, 194)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CustomIcon(
                                icon: Icons.photo_camera,
                              ),
                            )))
                  ],
                ),
              ),
            ),
            test("Name"),
            settingsItem(Icons.person, nameController),
            divider(),
            test("Address"),
            settingsItem(Icons.home, addressContoller),
            divider(),
            test("Email"),
            settingsItem(Icons.email, emailController),
            divider(),
            OutlinedButton(
              onPressed: () {
                builddialog(context, "");
              },
              style: OutlinedButton.styleFrom(shape: const LinearBorder()),
              child: const CustomText(text: "Choose Language"),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CSCPicker(
                showStates: true,
                showCities: true,
                flagState: CountryFlag.ENABLE,
                dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "State",
                citySearchPlaceholder: "City",

                countryDropdownLabel: "Country",
                stateDropdownLabel: "State",
                cityDropdownLabel: "City",

                defaultCountry: CscCountry.India,

                selectedItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownHeadingStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                dropdownItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownDialogRadius: 10.0,
                searchBarRadius: 10.0,
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },

                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },

                ///triggers once city selected in dropdown
                onCityChanged: (value) {
                  setState(() {
                    ///store value in city variable
                    cityValue = value;
                  });
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget settingsItem(IconData icon, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          CustomIcon(icon: icon),
          const SizedBox(
            height: 30,
            child: VerticalDivider(
              width: 70,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 250,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget test(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomText(
        text: text,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Divider(
        height: 20,
        color: Colors.black,
      ),
    );
  }
}
