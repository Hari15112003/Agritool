// ignore_for_file: file_names, avoid_print,, unused_import

import 'package:agritool/commodity/apiCall.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class CommodityPage extends StatefulWidget {
  const CommodityPage({super.key});

  @override
  State<CommodityPage> createState() => _CommodityPageState();
}

class _CommodityPageState extends State<CommodityPage> {
  @override
  void initState() {
    super.initState();
  }

  late List detials = [];

  String? stateValue = "Tamil Nadu";
  TextEditingController queryContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  "Commodity Price",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.grey.shade500.withOpacity(.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(13),
                    value: stateValue,
                    items: [
                      "Uttar Pradesh",
                      "Maharashtra",
                      "Haryana",
                      "Punjab",
                      "West Bengal",
                      "Kerala",
                      "Telangana",
                      "Madhya Pradesh",
                      "Odisha",
                      "Tripura",
                      "Himachal Pradesh",
                      "Rajasthan",
                      "Karnataka",
                      "Gujarat",
                      "Uttrakhand",
                      "NCT of Delhi",
                      "Chattisgarh",
                      "Bihar",
                      "Chandigarh",
                      "Tamil Nadu",
                      "Andhra Pradesh"
                    ]
                        .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        stateValue = value!;
                      });
                      print(stateValue);
                    },
                    isExpanded: true,
                    hint: const Text(
                      "Choose State",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: queryContoller,
              decoration: InputDecoration(
                  hintText: "Search for items",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13))),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              detials = [];
              var ap = await getdetails(
                state: stateValue.toString().trim(),
                commodity: queryContoller.text.trim(),
              );
              setState(() {
                detials.addAll(ap);
              });
              print(detials);
            },
            child: const Text("Search"),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: detials.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.grey.shade300.withOpacity(.4)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    detials[index]['commodity'].toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "District: ${detials[index]['district']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  columnHelper(
                                      title: "Min Price",
                                      value: detials[index]['min_price']),
                                  columnHelper(
                                      title: "Max Price",
                                      value: detials[index]['max_price']),
                                  columnHelper(
                                      title: "Modal Price",
                                      value: detials[index]['modal_price'])
                                ],
                              )
                            ]),
                      ),
                    );
                  }))
        ],
      ),
    ));
  }

  Widget columnHelper({required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(value),
      ],
    );
  }
}
