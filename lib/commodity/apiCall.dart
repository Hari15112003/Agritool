// ignore_for_file: file_names

import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

Future<List> getdetails(
    {String? state, String? district, String? commodity}) async {
  // String? encodedState = state != null ? Uri.encodeComponent(state) : null;
  // String? encodedCommodity =
  //     commodity != null ? Uri.encodeComponent(commodity) : null;
  String baseUrl =
      "https://api.data.gov.in/catalog/6141ea17-a69d-4713-b600-0a43c8fd9a6c?api-key=579b464db66ec23bdd000001ded3c9b9f8b248c05060d1d91eb0add9&format=json&limit=100";
  // String? encodedDistrict =
  //     district != null ? Uri.encodeComponent(district) : null;
  if (state != null && state.isNotEmpty) {
    baseUrl += '&filters[state]=$state';
  }
  if (district != null) {
    baseUrl += '&filters[district]=$district';
  }
  if (commodity != null && commodity.isNotEmpty) {
    baseUrl += '&filters[commodity]=$commodity';
  }

  var url = Uri.parse(baseUrl);
  var resp = await http.get(
    url,
  );
  if (resp.statusCode == 200) {
    var out = jsonDecode(resp.body);
    return (out['records'] as List);
  } else {
    return [];
  }
}
