import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'keys.dart';

class WeatherResult {
  List<Weather> weather;
  Main main;
  String name;
  
  WeatherResult({
    this.weather,
    this.main,
    this.name
});

  factory WeatherResult.fromJson(Map<String, dynamic> json) => new WeatherResult(
    weather: Weather.listFromJson(json["weather"]),
    main: Main.fromJson(json["main"]),
      name: json["name"]
  );

}

class Weather {
  int id;
  String main;
  String description;

  Weather({
    this.id,
    this.main,
    this.description
});

  static listFromJson(List<dynamic> json) {
    var list = <Weather>[];
    for (var j in json) {
        var w = Weather.fromJson(j);
        list.add(w);
    }
    return list;
  }

  factory Weather.fromJson(Map<String, dynamic> json) => new Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
  );
}

class Main {
  double temp;
  int pressure;

  Main({
    this.temp,
    this.pressure
}) ;

  factory Main.fromJson(Map<String, dynamic> json) => new Main(
      temp: json["temp"],
      pressure: json["pressure"]
  );
}

class ApiClient {

  static Future<WeatherResult> fetchWeather(String zip) async {
    final response = await http.get(UrlBuilder.zipUrl(zip));
    var jsonResult = json.decode(response.body.toString());
    var result = WeatherResult.fromJson(jsonResult);
    return result;
  }
}

class UrlBuilder{
  static zipUrl(String zip) {
      return Constants.zipUrl
          + zip
          + Constants.zipUrlSuffix
          + Constants.appIdKey
          + Keys.weatherApiKey
          + Constants.unitsType;
  }
}

class Constants {
  static String url = 'https://api.openweathermap.org/data/2.5/weather?q=Chicago&appid=f7bab9dab0e6debabbb9bd6a7fac0159&units=imperial';
  static String zipUrl = 'https://api.openweathermap.org/data/2.5/weather?zip=';
  static String zipUrlSuffix = ',us';
  static String appIdKey = '&appid=';
  static String unitsType = '&units=imperial';
}
