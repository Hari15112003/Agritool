import 'dart:io';

import 'package:agritool/community/community_model.dart';
import 'package:agritool/community/video_play.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MakePost extends StatefulWidget {
  const MakePost({super.key});

  @override
  State<MakePost> createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {
  TextEditingController heading = TextEditingController();
  TextEditingController subheading = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<File> imageFile = [];
  List<File> videoFile = [];

  @override
  void dispose() {
    super.dispose();
    heading.dispose();
    subheading.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ref = Provider.of<AuthProvider>(context);
    CustomSizeData size = CustomSizeData.from(context: context);
    double height = size.height;
    double width = size.width;
    return SafeArea(
        child: Scaffold(
      bottomSheet: SizedBox(
        height: height * 0.15,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 3,
                      controller: contentController,
                      onChanged: (text) {},
                      decoration: const InputDecoration(
                        hintText: 'Enter your text..',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none,
                            gapPadding: 0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.link,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.browse_gallery_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text("Create Post"),
                ],
              ),
              CustomTextField(
                controller: heading,
                hintText: '   Heading (Required)',
              ),
              CustomTextField(
                controller: subheading,
                hintText: '   Subheading (Optional)',
              ),
              imageFile.isNotEmpty
                  ? SizedBox(
                      height: height * 0.6,
                      child: ListView.builder(
                          itemCount: imageFile.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        imageFile.removeAt(index);
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.cancel),
                                    ),
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
                                            imageFile[index]),
                                      ),
                                    ),
                                  ]),
                            );
                          }),
                    )
                  : const SizedBox(
                      height: 20,
                    ),
              const SizedBox(height: 20),
              videoFile.isNotEmpty
                  ? SizedBox(
                      height: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: videoFile.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    videoFile.removeAt(index);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.cancel),
                                ),
                                Expanded(
                                    child: VideoPlayerWidget(
                                      type: 'file',
                                        videoFile: videoFile[index])),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(
                      height: 20,
                    ),
              ElevatedButton(
                  onPressed: () {
                    print(
                      videoFile,
                    );
                    print(imageFile);
                    CommunityModel post = CommunityModel(
                        userId: ref.firebaseAuth.currentUser!.uid,
                        date: DateTime.now().toString(),
                        profileImage: '',
                        name: "Harish",
                        heading: heading.text.trim(),
                        subheading: subheading.text.trim(),
                        imageUrl: imageFile,
                        videoUrl: videoFile,
                        content: contentController.text.trim());
                    ref
                        .addPostToFirestore(post)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('Post')),
              const SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future pickImage(ImageSource imageSource) async {
    List<FilePickerResult> results = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      results.add(result);
    }
    List<File> pickedFiles = [];
    for (FilePickerResult result in results) {
      if (result.files.isNotEmpty) {
        pickedFiles.addAll(result.paths.map((path) => File(path!)));
      }
    }
    for (File pickedFile in pickedFiles) {
      if (pickedFile.path.toLowerCase().endsWith('.jpg') ||
          pickedFile.path.toLowerCase().endsWith('.jpeg') ||
          pickedFile.path.toLowerCase().endsWith('.png')) {
        imageFile.add(pickedFile);
      } else if (pickedFile.path.toLowerCase().endsWith('.mp4') ||
          pickedFile.path.toLowerCase().endsWith('.mov')) {
        videoFile.add(pickedFile);
      }
    }
    setState(() {});
  }

  Image generatePreviewWidget(File file) {
    return Image.file(
      width: double.infinity,
      file,
      fit: BoxFit.cover,
    );
  }
}
