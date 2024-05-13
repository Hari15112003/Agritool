import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/shop/components/grocery_item_tile.dart';
import 'package:agritool/shop/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({super.key});

  @override
  State<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
    return SingleChildScrollView(
      primary: true,
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            // Let's order fresh items for you
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomText(
                text: "Let's order fresh items for you",
                fontSize: 36,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomText(
                text: "Fresh Items",
                fontSize: 18,
              ),
            ),

            // recent orders -> show last 3
            Expanded(
              flex: 1,
              child: Consumer<CartModel>(
                builder: (context, value, child) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: value.shopItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemBuilder: (context, index) {
                      return GroceryItemTile(
                        itemName: value.shopItems[index][0],
                        itemPrice: value.shopItems[index][1],
                        imagePath: value.shopItems[index][2],
                        color: value.shopItems[index][3],
                        onPressed: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
