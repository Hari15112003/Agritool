import 'package:agritool/calculator/fertilizer_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChooseFertilizerCalculator extends StatelessWidget {
  const ChooseFertilizerCalculator({super.key});

  final List _shopItems = const [
    // [itemName, itemPrice, imagePath, color],
    [
      "Tomato",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftomato.png?alt=media&token=34a631ab-3d6a-49df-a8f5-6ab1329477eb",
    ],
    [
      "Potato",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpotato.png?alt=media&token=7b1f5aa0-aa96-4bab-b5fa-5c07cc6d2af7",
    ],
    [
      "Carrot",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcarrot.png?alt=media&token=a79fc8d7-8d0d-4af9-b2c9-47956f6700a5",
    ],
    [
      "Onion",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fonion.png?alt=media&token=00f099e7-3046-4f08-8671-d816d22efd8a",
    ],
    [
      "Brinjal",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbrinjal.png?alt=media&token=7401ac19-9c3e-4167-8eae-fb6d7158f93e"
    ],
    [
      "Drumstick",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fdrumstick.png?alt=media&token=550273c1-4ffb-4aaf-b686-0e1b8602fc6a"
    ],
    [
      "Garlic",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgarlic.png?alt=media&token=af0fbdaf-0b37-4821-8b95-eec6ff16bac8"
    ],
    [
      "Beans",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbeans.png?alt=media&token=2f8fd7e6-81e9-4b45-b83c-395b729a0cbe"
    ],
    [
      "Ginger",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fginger.png?alt=media&token=ace5f7f7-d8dc-4e51-aed9-99a62593be85"
    ],
    [
      "Tamarind",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftamarind.png?alt=media&token=a8a9e56e-5466-4102-b54e-73d54b3494ce"
    ],
    [
      "Lady's finger",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fladys%20finger.png?alt=media&token=2321daa8-bf07-4228-b7b7-98d0ca43eeaa"
    ],
    [
      "Coconut",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcoconut.png?alt=media&token=6e9b9066-5ec9-46ea-a865-5a8506af2cdb"
    ],
    [
      "Mango",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fmango.png?alt=media&token=48872370-f892-48a9-b76a-f6cfe2937743",
    ],
    [
      "Guava",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fguava.png?alt=media&token=e2947cca-f369-4c8a-88c0-32fdc2addb52"
    ],
    [
      "Apple",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fapple.png?alt=media&token=12f8638c-6794-4b49-a6a8-ae40c2951baf"
    ],
    [
      "Pomegranate",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpomegranate.png?alt=media&token=68a844cf-58ea-4eb5-a64d-3fbcd1ecdf43"
    ],
    [
      "Banana",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbanana.png?alt=media&token=44355a44-2441-4015-a78d-f88c815077ac"
    ],
    [
      "Orange",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Forange.png?alt=media&token=d8fee31e-b1d4-4e37-ab51-d1945f347b9a"
    ],
    [
      "Grape",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgrape.png?alt=media&token=0c7dd27c-12bf-40af-ab78-dce3e8f5aa39"
    ],
    [
      "Paddy",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpaddy.png?alt=media&token=17bae812-52ef-4b22-bf0b-b28e74f72082"
    ],
    [
      "Wheat",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fwheat.png?alt=media&token=0117b69a-f2ca-433d-9019-f0fa21f9e772"
    ],
    [
      "Ragi",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fragi.png?alt=media&token=ee623098-6897-43ea-8151-538739f5366b"
    ],
    [
      "Kambu",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fkambu.png?alt=media&token=6bdbe4db-bcb0-4c30-a6bc-020d5b8c40fe"
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  "Choose Crop",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer()
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _shopItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.7),
                  itemBuilder: (_, int index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyCustomForm(type: _shopItems[index][0]),
                            ),
                          );
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
                            Text(
                              _shopItems[index][0],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                        );
                  }),
            ),
          ),
        ],
      )),
    );
  }
}
