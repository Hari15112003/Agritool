import 'package:agritool/crop/description.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom/custom_icon_button.dart';

class CropDetails extends StatefulWidget {
  final String item;
  final String itemImages;
  const CropDetails({super.key, required this.item, required this.itemImages});

  @override
  State<CropDetails> createState() => _CropDetailsState();
}

class _CropDetailsState extends State<CropDetails> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const CustomIcon(icon: Icons.arrow_back)),
                CustomText(
                  text: widget.item.toUpperCase(),
                ),
                CustomIconButton(
                  onPressed: () {},
                  icon: const CustomIcon(icon: Icons.search),
                ),
              ],
            ),
            Hero(
              tag: widget.item,
              child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Image(
                    image: CachedNetworkImageProvider(widget.itemImages),
                    fit: BoxFit.cover,
                  )),
            ),
            Row(children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomText(text: widget.item),
                ),
              ),
              CustomIconButton(
                onPressed: () {
                  setState(() {
                    favorite == true ? favorite = false : favorite = true;
                  });
                },
                icon: CustomIcon(
                    icon: favorite == true
                        ? Icons.favorite
                        : Icons.favorite_border),
              ),
              CustomIconButton(
                onPressed: () {},
                icon: const CustomIcon(
                  icon: Icons.share,
                ),
              )
            ]),
            listTileItems('1.${'introduction'.tr}', 0),
            divider(),
            listTileItems('2.${'soil'.tr}', 1),
            divider(),
            listTileItems('3.${'fertilizer'.tr}', 2),
            divider(),
            listTileItems('4.${'diseases'.tr}', 3),
            divider(),
            listTileItems('5.${'deficiency'.tr}', 4),
            divider(),
            listTileItems('6.${'irrigation'.tr}', 5),
            divider(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      height: 10,
      color: Colors.green,
    );
  }

  Widget listTileItems(String text, int number) {
    return ListTile(
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      title: CustomText(text:  '${widget.item.toLowerCase()}_${text.substring(2)}'.tr),
      onTap: () {
        context.push(
          Description(
            step: text,
            step_index: number,
            crop_item: widget.item.toLowerCase(),
          ),
        );
      },
    );
  }
}
