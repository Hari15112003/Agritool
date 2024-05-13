// ignore_for_file: file_names

import 'dart:convert';
import 'dart:core';

import 'package:agritool/const/api_const.dart';
import 'package:http/http.dart' as http;

Future<List> getdetails(
    {String? state, String? district, String? commodity}) async {
  String baseUrl = ApiConstant.commodityApi;

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
