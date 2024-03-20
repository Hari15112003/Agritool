// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:io';

import 'package:agritool/calculator/choose_crop.dart';
import 'package:agritool/commodity/commodityPage.dart';
import 'package:agritool/diseases/scanning_screen.dart';
import 'package:agritool/youtube/example.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../models/weather/services/weather_services.dart';
import '../models/weather/weather_model.dart';
import '../news/pages/new_pages.dart';
import '../utils/widget.dart';

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
      showSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    loadModel();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/json/sunny.json";

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/json/cloudy.json";

      case 'drizzle':
        return "assets/json/sunny_rainy.json";
      case 'rain':
      case 'shower rain':
        return "assets/json/rain.json";
      case 'thunderstorm':
        return "assets/json/thunder.json";
      case 'clear':
        return "assets/json/sunny.json";
      default:
        return "assets/json/sunny.json";
    }
  }

  final List items = const [
    // [ itemName, itemPrice, imagePath, color ]
    [
      "Popular News",
      NewsPage(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fnews.png?alt=media&token=e3c456f5-c018-4c82-8599-e3f5177bdbe2",
      Colors.green
    ],
    [
      "Disease detection",
      NewsPage(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fscanner.png?alt=media&token=46886fbd-8e0a-4b1c-8896-957d6c88d10d",
      Colors.yellow,
    ],
    [
      "Commodity Price",
      CommodityPage(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fmarket_price.png?alt=media&token=d443555a-7474-4402-bafb-f6019c402ecb",
      Colors.brown
    ],
    [
      "Fertilizer Calculator",
      ChooseFertilizerCalculator(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fcalculator.png?alt=media&token=62c5e466-48d2-4e77-8a8e-d3db004a5e07",
      Colors.blue
    ],
    // ["Avocado", NewsPage(), "lib/example/images/avocado.png", Colors.green],
    // ["Banana", NewsPage(), "lib/example/images/banana.png", Colors.yellow],
    // ["Chicken", NewsPage(), "lib/example/images/chicken.png", Colors.brown],
    // ["Water", NewsPage(), "lib/example/images/water.png", Colors.blue],
  ];
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
        model: "assets/model/model_unquant.tflite",
        labels: "assets/model/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                        child: Text(
                          _weather?.cityName ?? "loading city..",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          "${_weather?.temperature.round()}°C",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          DateFormat.yMMMEd().format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 89, 87, 87)),
                        ),
                      )
                    ],
                  ),
                ),
                ClipRect(
                  child: Lottie.asset(
                      getWeatherAnimation(_weather?.mainCondition),
                      height: height * 0.20),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => items[index][1]));
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  // icon: Icon(Icons.abc),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: Text('identifydisease'.tr),
                                  content: Text('Choose the method'.tr),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => pickImageFromCamera(),
                                      child: Text('takeapic'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () => pickImageFromGallery(),
                                      child: Text('choosefromgallery'.tr),
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
                                  Text(
                                    items[index][0],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ]))));
              }),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
            icon: const Icon(Icons.video_call)),
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => const Payment()));
        //     },
        //     child: const Text("check me"))
      ],
    );
  }

  Future pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      image = File(pickedFile!.path);
    });
    await classifyDisease(image);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ScanningScreen(
        image: image,
        results: results,
      );
    }));
  }

  Future pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      image = File(pickedFile!.path);
    });
    await classifyDisease(image);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ScanningScreen(image: image, results: results);
    }));
  }
}
