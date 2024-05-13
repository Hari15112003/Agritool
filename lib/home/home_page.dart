// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:io';

import 'package:agritool/const/image_const.dart';
import 'package:agritool/const/list_const.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/diseases/scanning_screen.dart';
import 'package:agritool/youtube/example.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../custom/custom_icon_button.dart';
import '../models/weather/services/weather_services.dart';
import '../models/weather/weather_model.dart';
import '../custom/custom_snackBar.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
//api key
  final _weatherService = WeatherService('84f19184e5d3f6b1583762199f2a3213');

  //fetching weather
  Weather? _weather;
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    loadModel();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return ImageConst.sunnyLottie;

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return ImageConst.cloudLottie;

      case 'drizzle':
        return ImageConst.sunnyRainyLottie;
      case 'rain':
      case 'shower rain':
        return ImageConst.rainLottie;
      case 'thunderstorm':
        return ImageConst.thunderLottie;
      case 'clear':
        return ImageConst.sunnyLottie;
      default:
        return ImageConst.sunnyLottie;
    }
  }

  final List items = ListContants.homeItems;

  late File image;
  List results = [];
  bool imageSelected = false;
  bool isOut = false;

  Future classifyDisease(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path, // required
      imageMean: 127.5, // defaults to 117.0
      imageStd: 127.5, // defaults to 1.0
      numResults: 2, // defaults to 5
      threshold: 0.2, // defaults to 0.1
    );
    setState(() {
      results = recognitions!;

      image = image;
      imageSelected = true;
    });
  }

  Future loadModel() async {
    Tflite.close();
    String? res;
    res = await Tflite.loadModel(
        model: ImageConst.modelFile,
        labels: ImageConst.modelFileLabel,
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);
    double width = size.width;
    double height = size.height;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(height * 0.022),
          child: Container(
            height: height * 0.20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.20,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 40),
                        child: CustomText(
                          text: _weather?.cityName ?? "loading city..",
                          textAlign: TextAlign.left,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: size.mediumtext,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: CustomText(
                          text: "${_weather?.temperature.round()}°C",
                          color: Colors.black,
                          fontSize: size.largetext,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: CustomText(
                          text: DateFormat.yMMMEd().format(DateTime.now()),
                          color: const Color.fromARGB(255, 89, 87, 87),
                        ),
                      )
                    ],
                  ),
                ),
                ClipRect(
                  child: Lottie.asset(
                    getWeatherAnimation(_weather?.mainCondition),
                    height: height * 0.20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 2, childAspectRatio: 1),
              itemBuilder: (_, int index) {
                return InkWell(
                    onTap: () {
                      if (index != 1) {
                        context.push(items[index][1]);
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  // icon: Icon(Icons.abc),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: CustomText(text: 'identifydisease'.tr),
                                  content:
                                      CustomText(text: 'Choose the method'.tr),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          pickImage(from: 'camera'),
                                      child: Text('takeapic'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          pickImage(from: 'gallery'),
                                      child: CustomText(
                                        text: 'choosefromgallery'.tr,
                                      ),
                                    ),
                                  ],
                                ));
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: items[index][3].shade100,
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // item image
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Image(
                                      image: CachedNetworkImageProvider(
                                        items[index][2],
                                      ),
                                      height: 120,
                                    ),
                                  ),

                                  // item name
                                  CustomText(
                                    text: items[index][0],
                                    fontSize: 16,
                                  ),
                                ]))));
              }),
        ),
        CustomIconButton(
          onPressed: () {
            context.push(const MyHomePage());
          },
          icon: const CustomIcon(
            icon: Icons.video_call,
          ),
        ),
      ],
    );
  }

  Future pickImage({required String from}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: from == 'gallery' ? ImageSource.gallery : ImageSource.camera,
    );
    setState(() {
      image = File(pickedFile!.path);
    });
    await classifyDisease(image);
    context.push(ScanningScreen(image: image, results: results));
  }
}
