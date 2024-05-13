import 'dart:io';

import 'package:agritool/community/community_model.dart';
import 'package:agritool/community/video_play.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/custom/custom_text_field.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
                  CustomIconButton(
                    onPressed: () {},
                    icon: const CustomIcon(
                      icon: Icons.link,
                    ),
                  ),
                  CustomIconButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const CustomIcon(
                      icon: Icons.browse_gallery_rounded,
                    ),
                  ),
                  CustomIconButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const CustomIcon(
                      icon: Icons.camera_alt_rounded,
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
                  CustomIconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const CustomIcon(icon: Icons.arrow_back)),
                  const CustomText(text: "Create Post"),
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
                                    CustomIconButton(
                                      onPressed: () {
                                        imageFile.removeAt(index);
                                        setState(() {});
                                      },
                                      icon:
                                          const CustomIcon(icon: Icons.cancel),
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
                                CustomIconButton(
                                  onPressed: () {
                                    videoFile.removeAt(index);
                                    setState(() {});
                                  },
                                  icon: const CustomIcon(icon: Icons.cancel),
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
                    ref.addPostToFirestore(post).then(
                          (value) => context.pop(),
                        );
                  },
                  child: const CustomText(text: 'Post')),
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
