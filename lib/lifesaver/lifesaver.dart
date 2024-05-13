import 'package:agritool/const/list_const.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';

class LifeSaver extends StatefulWidget {
  const LifeSaver({super.key});

  @override
  State<LifeSaver> createState() => _LifeSaverState();
}

class _LifeSaverState extends State<LifeSaver> {
  List<String> seedDonationTitle = ListContants.seedDonationTitle;

  List<String> plantDonationTitle = ListContants.plantDonationTitle;
  List<String> plantDonationDescription = ListContants.plantDonationDescription;
  List<String> seedDonationDescription = ListContants.seedDonationDescription;
// These NGOs vary in their specific focus areas, but they all contribute to promoting sustainable agriculture, seed sovereignty, and rural development in Tamil Nadu.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const CustomIcon(icon: Icons.arrow_back)),
                    const CustomText(text: "Life Saver", fontSize: 18),
                    const Spacer()
                  ],
                ),
              ),
              const CustomText(text: "Seed Donation"),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: seedDonationTitle.length,
                  itemBuilder: (build, index) {
                    return ExpansionTile(
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      title: CustomText(text: seedDonationTitle[index]),
                      children: [
                        CustomText(
                          text: seedDonationDescription[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const CustomText(text: "Plant Donation"),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: plantDonationTitle.length,
                  itemBuilder: (build, index) {
                    return ExpansionTile(
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      title: CustomText(text: plantDonationTitle[index]),
                      children: [
                        CustomText(
                          text: plantDonationDescription[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
