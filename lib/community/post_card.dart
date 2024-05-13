import 'dart:io';

import 'package:agritool/community/community_model.dart';
import 'package:agritool/community/video_play.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class PostCard extends StatelessWidget {
  final CommunityModel posts;
  const PostCard({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
    double width = size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: posts.name,
                    fontWeight: FontWeight.bold,
                    fontSize: size.largetext,
                  ),
                  CustomText(
                    text: posts.date,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ReadMoreText(
            posts.content,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          posts.imageUrl!.isNotEmpty && posts.imageUrl != null
              ? SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                      itemCount: posts.imageUrl!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: width * 0.9,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: generatePreviewWidget(
                                        posts.imageUrl![index]),
                                  ),
                                ),
                              ]),
                        );
                      }),
                )
              : const SizedBox(),
          const SizedBox(
            height: 20,
          ),
          posts.videoUrl!.isNotEmpty && posts.videoUrl != null
              ? SizedBox(
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: posts.videoUrl!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: VideoPlayerWidget(
                                    type: 'network',
                                    videoFile: posts.videoUrl![index])),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
          const Divider(
            thickness: 10,
          ),
        ],
      ),
    );
  }

  Image generatePreviewWidget(File file) {
    return Image.network(
      width: double.infinity,
      file.path,
      fit: BoxFit.cover,
    );
  }
}
