import 'dart:io';

import 'package:agritool/community/community_model.dart';
import 'package:agritool/community/make_post.dart';
import 'package:agritool/community/post_card.dart';
import 'package:agritool/custom/custom_textfield.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    var ref = Provider.of<AuthProvider>(context);
    return SingleChildScrollView(
        child: StreamBuilder(
            stream: ref.firebaseFirestore.collection('posts').snapshots(),
            builder: (context, snaphot) {
              if (!snaphot.hasData) return const CircularProgressIndicator();
              String name = "";
              String profileImage = "";
              List<CommunityModel> postData = [];

              for (var document in snaphot.data!.docs) {
                Map<String, dynamic> docref = document.data();
                name = docref['name'];
                profileImage = docref['profilePic'];
                Map<String, dynamic> posts = document.data()['post'];

                for (var date in posts.keys) {
                  postData.add(
                    CommunityModel(
                      userId: '',
                      date: date,
                      profileImage: profileImage,
                      name: name,
                      content: posts[date]['content'],
                      heading: posts[date]['heading'],
                      imageUrl: [
                        if (posts[date]['imageUrl'] != null)
                          for (var i in posts[date]['imageUrl']) File(i)
                      ],
                      videoUrl: [
                        if (posts[date]['videoUrl'] != null)
                          for (var i in posts[date]['videoUrl']) File(i)
                      ],
                    ),
                  );
                }
                // CommunityModel a = CommunityModel(
                //     userId: 'userId',
                //     date: e.key,
                //     profileImage: profileImage,
                //     name: name,
                //     content: e.value[],
                //     heading: heading);

                // CommunityModel as = CommunityModel(
                //   imageUrl: ,
                //   videoUrl: ,
                //     userId: userId,
                //     subheading: ,
                //     date: date,
                //     profileImage: 'profileImage',
                //     name: name,
                //     content: content,
                //     heading: heading);
              }

              return Column(
                children: [
                  ...List.generate(
                    postData.length,
                    (index) => PostCard(
                      posts: postData[index],
                    ),
                  ),
                ],
              );
            }));
  }
}
