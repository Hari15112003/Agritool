import 'package:agritool/crop/description.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text(
                  widget.item.toUpperCase(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.amber),
                child: Image(
                  image: CachedNetworkImageProvider(widget.itemImages),
                  fit: BoxFit.cover,
                )
                // ,.C(
                //   widget.itemImages,
                //   fit: BoxFit.cover,
                // )
                ),
            Row(children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(widget.item),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      favorite == true ? favorite = false : favorite = true;
                    });
                  },
                  icon: Icon(favorite == true
                      ? Icons.favorite
                      : Icons.favorite_border)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share))
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
            // listTileItems('7.${''.tr}', 7),
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
      title: Text('${widget.item.toLowerCase()}_${text.substring(2)}'.tr),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Description(
              step: text,
              step_index: number,
              crop_item: widget.item.toLowerCase(),
            ),
          ),
        );
      },
    );
  }
}
