import 'package:agritool/commodity/apiCall.dart';
import 'package:agritool/custom/custom_back_button.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<CartModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Let's order fresh items for you
                const CustomBackButton(
                  text: 'GO BACK',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomText(
                    text: "My Cart",
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // list view of cart
                value.cartItems.length != 0
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListView.builder(
                            itemCount: value.cartItems.length,
                            padding: const EdgeInsets.all(12),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    leading: Image(
                                      image: CachedNetworkImageProvider(
                                        value.cartItems[index][2],
                                      ),
                                      height: 36,
                                    ),
                                    title: CustomText(
                                        text: value.cartItems[index][0],
                                        fontSize: 18),
                                    subtitle: CustomText(
                                        text: value.cartItems[index][1] + '\$',
                                        fontSize: 12),
                                    trailing: CustomIconButton(
                                      icon:
                                          const CustomIcon(icon: Icons.cancel),
                                      onPressed: () => Provider.of<CartModel>(
                                              context,
                                              listen: false)
                                          .removeItemFromCart(index),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CustomText(
                            text: 'Nothing is added in cart',
                          ),
                        ),
                      ),

                // total amount + pay now

                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Total Price',
                              color: Colors.green[200],
                            ),

                            const SizedBox(height: 8),
                            // total price
                            GestureDetector(
                              onTap: () async {},
                              child: CustomText(
                                text: '\$${value.calculateTotal()}',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // pay now
                        GestureDetector(
                          onTap: () async {
                            await getdetails(
                              state: "Tamil Nadu",
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade200),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Row(
                              children: [
                                CustomText(
                                    text: 'Pay Now', color: Colors.white),
                                CustomIcon(
                                  icon: Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
