// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Description extends StatefulWidget {
  final String step;
  final int step_index;
  final String crop_item;

  const Description(
      {super.key,
      required this.step,
      required this.step_index,
      required this.crop_item});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late int stepper;

  late String cropitem;

  @override
  void initState() {
    super.initState();

    stepper = widget.step_index;
    cropitem = widget.step.substring(2);
    setState(() {});
  }

  String bulletin = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    var description = {
      "introduction": [
        // 9
        "${widget.crop_item}_introduction".tr,
        "${widget.crop_item}_introduction_content1".tr,
        "${widget.crop_item}_introduction_content2".tr,
        "${widget.crop_item}_introduction_content3".tr,
        "${widget.crop_item}_introduction_content4".tr,
        "${widget.crop_item}_climate".tr,
        "${widget.crop_item}_climate_content1".tr,
        "${widget.crop_item}_climate_content2".tr,
        "${widget.crop_item}_climate_content3".tr,
      ],
      "soil": [
        // 9
        "${widget.crop_item}_soil".tr,
        "${widget.crop_item}_soil_content1".tr,
        "${widget.crop_item}_soil_content2".tr,
        "${widget.crop_item}_soil_content3".tr,
        "${widget.crop_item}_soil_content4".tr,
        "${widget.crop_item}_variety".tr,
        "${widget.crop_item}_variety_content1".tr,
        "${widget.crop_item}_variety_content2".tr,
        "${widget.crop_item}_variety_content3".tr,
      ],
      "fertilizer": [
        // 8
        "${widget.crop_item}_fertilizer".tr,
        "${widget.crop_item}_fertilizer_content1".tr,
        "${widget.crop_item}_fertilizer_content2".tr,
        "${widget.crop_item}_fertilizer_content3".tr,
        "${widget.crop_item}_fertilizer_content4".tr,
        "${widget.crop_item}_fertilizer_content5".tr,
        "${widget.crop_item}_fertilizer_content6".tr,
        "${widget.crop_item}_fertilizer_content7".tr,
      ],
      "diseases": [
        // 7
        "${widget.crop_item}_diseases".tr,
        "${widget.crop_item}_diseases_content1".tr,
        "${widget.crop_item}_diseases_content2".tr,
        "${widget.crop_item}_diseases_content3".tr,
        "${widget.crop_item}_diseases_content4".tr,
        "${widget.crop_item}_diseases_content5".tr,
        "${widget.crop_item}_diseases_content6".tr,
      ],
      "deficiency": [
        // 7
        "${widget.crop_item}_deficiency".tr,
        "${widget.crop_item}_deficiency_content1".tr,
        "${widget.crop_item}_deficiency_content2".tr,
        "${widget.crop_item}_deficiency_content3".tr,
        "${widget.crop_item}_deficiency_content4".tr,
        "${widget.crop_item}_deficiency_content5".tr,
        "${widget.crop_item}_deficiency_content6".tr,
      ],
      "irrigation": [
        // 19
        "${widget.crop_item}_irrigation".tr,
        "${widget.crop_item}_irrigation_content1".tr,
        "${widget.crop_item}_irrigation_content2".tr,
        "${widget.crop_item}_irrigation_content3".tr,
        "${widget.crop_item}_irrigation_content4".tr,
        "${widget.crop_item}_irrigation_content5".tr,
        "${widget.crop_item}_irrigation_content6".tr,
        "${widget.crop_item}_irrigation_content7".tr,
        "${widget.crop_item}_irrigation_content8".tr,
        "${widget.crop_item}_irrigation_content9".tr,
        "${widget.crop_item}_harvest".tr,
        "${widget.crop_item}_harvest_content1".tr,
        "${widget.crop_item}_harvest_content2".tr,
        "${widget.crop_item}_harvest_content3".tr,
        "${widget.crop_item}_harvest_content4".tr,
        "${widget.crop_item}_harvest_content5".tr,
        "${widget.crop_item}_harvest_content6".tr,
        "${widget.crop_item}_harvest_content7".tr,
        "${widget.crop_item}_harvest_content8".tr,
      ],
    };

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomText(text: widget.crop_item.toString().toUpperCase()),
            Align(
              alignment: Alignment.centerRight,
              child: CustomIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const CustomIcon(icon: Icons.cancel)),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: (cropitem == "introduction" && stepper == 0)
                    ? 9
                    : (cropitem == "soil" && stepper == 1)
                        ? 9
                        : (cropitem == "fertilizer" && stepper == 2)
                            ? 8
                            : (cropitem == "diseases" && stepper == 3)
                                ? 7
                                : (cropitem == "deficiency" && stepper == 4)
                                    ? 7
                                    : 19,
                itemBuilder: (context, index) {
                  if (cropitem == "introduction" && stepper == 0) {
                    if (index == 0 || index == 5) {
                      return boldtext(description[cropitem]![index]);
                    } else {
                      return smalltext(description[cropitem]![index]);
                    }
                  } else if (cropitem == "soil" && stepper == 1) {
                    if (index == 0 || index == 5) {
                      return boldtext(description[cropitem]![index]);
                    } else {
                      return smalltext(description[cropitem]![index]);
                    }
                  } else if (cropitem == "fertilizer" && stepper == 2) {
                    if (index == 0) {
                      return boldtext(description[cropitem]![index]);
                    } else {
                      return smalltext(description[cropitem]![index]);
                    }
                  } else if (cropitem == "diseases" && stepper == 3) {
                    if (index == 0 || index == 1) {
                      return boldtext(description[cropitem]![index]);
                    } else {
                      return smalltext(description[cropitem]![index]);
                    }
                  } else if (cropitem == "deficiency" && stepper == 4) {
                    if (index == 0) {
                      return boldtext(description[cropitem]![index]);
                    } else {
                      return smalltext(description[cropitem]![index]);
                    }
                  } else {
                    if (index == 0 || index == 1 || index == 10) {
                      return boldtext(description[cropitem]![index]);
                    } else {
                      return smalltext(description[cropitem]![index]);
                    }
                  }
                },
              ),
            ),
          ],
        ),
        bottomSheet:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CustomText(text: stepper.toString() + " of " + '5'),
          TextButton(
              onPressed: () {
                String choosen = "";
                setState(() {
                  if (stepper != 0) stepper -= 1;
                });
                if (stepper == 0) {
                  choosen = 'introduction';
                } else if (stepper == 1) {
                  choosen = "soil";
                } else if (stepper == 2) {
                  choosen = "fertilizer";
                } else if (stepper == 3) {
                  choosen = "diseases";
                } else if (stepper == 4) {
                  choosen = "deficiency";
                } else {
                  choosen = "irrigation";
                }

                setState(() {
                  cropitem = choosen;
                });
              },
              child: const CustomText(text: 'Previous')),
          TextButton(
              onPressed: () {
                String choosen = "";
                setState(() {
                  if (stepper < 5) stepper += 1;
                });
                if (stepper == 0) {
                  choosen = 'introduction';
                } else if (stepper == 1) {
                  choosen = "soil";
                } else if (stepper == 2) {
                  choosen = "fertilizer";
                } else if (stepper == 3) {
                  choosen = "diseases";
                } else if (stepper == 4) {
                  choosen = "deficiency";
                } else {
                  choosen = "irrigation";
                }

                setState(() {
                  cropitem = choosen;
                });
              },
              child: const CustomText(text: 'Next'))
        ]),
      ),
    );
  }

  Widget boldtext(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomText(text: text, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget smalltext(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomText(
        text: bulletin + text,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
