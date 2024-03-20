import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  // final List _shopItems = const [
  //   // [ itemName, itemPrice, imagePath, color ]
  //   ["Avocado", "4.00", "lib/example/images/avocado.png", Colors.green,Colors.green],
  //   ["Banana", "2.50", "lib/example/images/banana.png", Colors.yellow],
  //   ["Chicken", "12.80", "lib/example/images/chicken.png", Colors.brown],
  //   ["Water", "1.00", "lib/example/images/water.png", Colors.blue],
  //   ["Avocado", "4.00", "lib/example/images/avocado.png", Colors.green],
  //   ["Banana", "2.50", "lib/example/images/banana.png", Colors.yellow],
  //   ["Chicken", "12.80", "lib/example/images/chicken.png", Colors.brown],
  //   ["Water", "1.00", "lib/example/images/water.png", Colors.blue],
  // ];
  final List _shopItems = const [
    // [itemName, itemPrice, imagePath, color],
    [
      "Tomato",
      "40",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftomato.png?alt=media&token=34a631ab-3d6a-49df-a8f5-6ab1329477eb",
      Colors.green
    ],
    [
      "Potato",
      "50",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpotato.png?alt=media&token=7b1f5aa0-aa96-4bab-b5fa-5c07cc6d2af7",
      Colors.green
    ],
    [
      "Carrot",
      "60",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcarrot.png?alt=media&token=a79fc8d7-8d0d-4af9-b2c9-47956f6700a5",
      Colors.green
    ],
    [
      "Onion",
      "30",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fonion.png?alt=media&token=00f099e7-3046-4f08-8671-d816d22efd8a",
      Colors.green
    ],
    [
      "Brinjal",
      "63",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbrinjal.png?alt=media&token=7401ac19-9c3e-4167-8eae-fb6d7158f93e",
      Colors.green
    ],
    [
      "Drumstick",
      "120",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fdrumstick.png?alt=media&token=550273c1-4ffb-4aaf-b686-0e1b8602fc6a",
      Colors.green
    ],
    [
      "Garlic",
      "180",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgarlic.png?alt=media&token=af0fbdaf-0b37-4821-8b95-eec6ff16bac8",
      Colors.green
    ],
    [
      "Beans",
      "30",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbeans.png?alt=media&token=2f8fd7e6-81e9-4b45-b83c-395b729a0cbe",
      Colors.green
    ],
    [
      "Ginger",
      "220",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fginger.png?alt=media&token=ace5f7f7-d8dc-4e51-aed9-99a62593be85",
      Colors.green
    ],
    [
      "Tamarind",
      "200",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftamarind.png?alt=media&token=a8a9e56e-5466-4102-b54e-73d54b3494ce",
      Colors.green
    ],
    [
      "Lady's finger",
      "35",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fladys%20finger.png?alt=media&token=2321daa8-bf07-4228-b7b7-98d0ca43eeaa",
      Colors.green
    ],
    [
      "Coconut",
      "25",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcoconut.png?alt=media&token=6e9b9066-5ec9-46ea-a865-5a8506af2cdb",
      Colors.green
    ],
    [
      "Mango",
      "70",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fmango.png?alt=media&token=48872370-f892-48a9-b76a-f6cfe2937743",
      Colors.green
    ],
    [
      "Guava",
      "80",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fguava.png?alt=media&token=e2947cca-f369-4c8a-88c0-32fdc2addb52",
      Colors.green
    ],
    [
      "Apple",
      "250",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fapple.png?alt=media&token=12f8638c-6794-4b49-a6a8-ae40c2951baf",
      Colors.green
    ],
    [
      "Pomegranate",
      "150",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpomegranate.png?alt=media&token=68a844cf-58ea-4eb5-a64d-3fbcd1ecdf43",
      Colors.green
    ],
    [
      "Banana",
      "55",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbanana.png?alt=media&token=44355a44-2441-4015-a78d-f88c815077ac",
      Colors.green
    ],
    [
      "Orange",
      "120",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Forange.png?alt=media&token=d8fee31e-b1d4-4e37-ab51-d1945f347b9a",
      Colors.green
    ],
    [
      "Grape",
      "80",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgrape.png?alt=media&token=0c7dd27c-12bf-40af-ab78-dce3e8f5aa39",
      Colors.green
    ],
    [
      "Paddy",
      "62",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpaddy.png?alt=media&token=17bae812-52ef-4b22-bf0b-b28e74f72082",
      Colors.green
    ],
    [
      "Wheat",
      "145",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fwheat.png?alt=media&token=0117b69a-f2ca-433d-9019-f0fa21f9e772",
      Colors.green
    ],
    [
      "Ragi",
      "135",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fragi.png?alt=media&token=ee623098-6897-43ea-8151-538739f5366b",
      Colors.green
    ],
    [
      "Kambu",
      "168",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fkambu.png?alt=media&token=6bdbe4db-bcb0-4c30-a6bc-020d5b8c40fe",
      Colors.green
    ]
  ];

  // list of cart items
  final List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
