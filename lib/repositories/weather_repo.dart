import 'dart:convert';

import 'package:youtobe_demo/models/weather.dart';
import 'package:youtobe_demo/utils/app_contants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class WeatherRepo{

  String key = '10877265c57140f35953274a08cfb85a';



  Future<CurrentModel> getWeather(String lat, String lon) async{
    String url = '${AppConstants.WEATHER_BASE_URI}/data/2.5/onecall?lat=${lat}&lon=${lon}&appid=${key}&lang=vi';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final list = json.decode(response.body) as Map<dynamic, dynamic>;
      CurrentModel listMember = CurrentModel.fromJson(list['current']);
      return listMember;
    } else {

      throw Exception(response.statusCode);
    }


  }

}