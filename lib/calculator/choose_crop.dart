import 'package:agritool/calculator/fertilizer_calculator.dart';
import 'package:agritool/const/list_const.dart';
import 'package:agritool/custom/custom_back_button.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChooseFertilizerCalculator extends StatelessWidget {
  const ChooseFertilizerCalculator({super.key});

  final List _shopItems = ListContants.shopItems;

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomBackButton(text: 'Choose Crop'),
            SizedBox(
              height: height * 0.8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _shopItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 2,
                            childAspectRatio: 0.7),
                    itemBuilder: (_, int index) {
                      return InkWell(
                          onTap: () {
                            context
                                .push(MyCustomForm(type: _shopItems[index][0]));
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.green.shade100.withOpacity(.5),
                                      shape: BoxShape.circle,
                                      border: const Border()),
                                  child: Image(
                                      image: CachedNetworkImageProvider(
                                          _shopItems[index][1])),
                                ),
                              ),
                              CustomText(
                                  text: _shopItems[index][0],
                                  fontWeight: FontWeight.bold),
                            ],
                          ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
