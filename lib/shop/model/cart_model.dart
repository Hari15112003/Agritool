import 'package:agritool/const/list_const.dart';
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
  final List _shopItems = ListContants.shoppingItemsCost;

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
