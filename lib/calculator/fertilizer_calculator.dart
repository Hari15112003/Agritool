// ignore_for_file: library_private_types_in_public_api

import 'package:agritool/custom/custom_back_button.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCustomForm extends StatefulWidget {
  final String type;

  const MyCustomForm({super.key, required this.type});
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  bool showValue = false;

  final myController = TextEditingController();

  String? val;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  String mopValue = "";
  String dapValue = "";
  String ureaValue = "";

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            const CustomBackButton(text: 'Fertilizer'),
            CustomText(
                text: "fertilizercalc".tr,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: height * 0.04,
            ),
            CustomText(
                text: 'enterplotsize'.tr,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.bold,
                color: Colors.green),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  hintText: "enterinacres".tr,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(Icons.area_chart),
                  ),
                ),
                controller: myController,
                keyboardType: TextInputType.number,
              ),
            ),
            CustomText(
                text: 'acres'.tr,
                textAlign: TextAlign.right,
                color: Colors.green),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                if (showValue)
                  Column(
                    children: <Widget>[
                      CustomText(
                          text:
                              'We advise you not to use Chemicals for the next 45 days...'
                                  .tr,
                          fontSize: 16),
                    ],
                  ),
                CheckboxListTile(
                  title: CustomText(text: "Natural Enemies in your Field".tr),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: showValue,
                  onChanged: (bool? showvalue) {
                    setState(() {
                      showValue = showvalue!;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (myController.text.toString().trim().isNotEmpty) {
                        setState(() {
                          val = calculation(myController);
                        });
                      } else {
                        showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content:
                                    Text("Please enter the correct field".tr),
                                actions: [
                                  TextButton(
                                    child: Text("OK".tr),
                                    onPressed: () {
                                      // Navigator.pop(context, 'Cancel'.tr);
                                      context.pop('Cancel'.tr);
                                    },
                                  ),
                                ],
                                title: CustomText(text: "Error".tr),
                              );
                            });
                      }
                    },
                    child: const CustomText(text: "Calculate")),
                const SizedBox(
                  height: 10,
                ),
                mopValue.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(.2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            rowhelper(title: "Urea", value: ureaValue),
                            rowhelper(title: "DAP", value: dapValue),
                            rowhelper(title: "MOP", value: mopValue)
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rowhelper({required String title, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            text: title, fontWeight: FontWeight.bold, color: Colors.green),
        CustomText(text: value),
      ],
    );
  }

  String calculation(
    TextEditingController myController,
  ) {
    double acre = double.parse(myController.text);
    double dap, mop, urea = 0.0;
    String type = widget.type.toString().trim().toLowerCase();

    if (type == 'apple') {
      dap = 25;
      mop = 15;
      urea = 30;
    } else if (type == 'mango') {
      dap = 30;
      mop = 20;
      urea = 35;
    } else if (type == 'corn') {
      dap = 20;
      mop = 25;
      urea = 15;
    } else if (type == 'soybean') {
      dap = 15;
      mop = 30;
      urea = 20;
    } else if (type == 'grape') {
      dap = 35;
      mop = 15;
      urea = 25;
    } else if (type == 'orange') {
      dap = 25;
      mop = 30;
      urea = 20;
    } else if (type == 'strawberry') {
      dap = 30;
      mop = 25;
      urea = 15;
    } else if (type == 'guava') {
      dap = 20;
      mop = 35;
      urea = 15;
    } else if (type == 'pomegranate') {
      dap = 30;
      mop = 20;
      urea = 25;
    } else if (type == 'coriander') {
      dap = 15;
      mop = 25;
      urea = 30;
    } else if (type == 'cherry') {
      dap = 25;
      mop = 15;
      urea = 30;
    } else if (type == 'lemon') {
      dap = 30;
      mop = 20;
      urea = 35;
    } else if (type == 'cucumber') {
      dap = 30;
      mop = 17;
      urea = 51;
    } else if (type == 'pepper') {
      dap = 27;
      mop = 17;
      urea = 40;
    } else if (type == 'potato') {
      dap = 26;
      mop = 40;
      urea = 56;
    } else if (type == 'tomato') {
      dap = 22;
      mop = 28;
      urea = 45;
    } else {
      dap = 20;
      mop = 10;
      urea = 10;
    }
    dap = dap * acre * 2;
    mop = mop * acre * 2;

    urea = urea * acre * 2;

    setState(() {
      mopValue = "$mop kg";
      dapValue = "$dap kg";
      ureaValue = "$urea kg";
    });

    return 'MOP: $mop kg,\nDAP: $dap kg \nUrea: $urea kg';
  }
}
