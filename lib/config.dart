
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpers/noticiasStream.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(1, 10, 83, .1),
  100: Color.fromRGBO(1, 10, 83, .2),
  200: Color.fromRGBO(1, 10, 83, .3),
  300: Color.fromRGBO(1, 10, 83, .4),
  400: Color.fromRGBO(1, 10, 83, .5),
  500: Color.fromRGBO(1, 10, 83, .6),
  600: Color.fromRGBO(1, 10, 83, .7),
  700: Color.fromRGBO(1, 10, 83, .8),
  800: Color.fromRGBO(1, 10, 83, .9),
  900: Color.fromRGBO(1, 10, 83, 1),
};

class Config {
  static MaterialColor colorCustom = MaterialColor(0xFF010a53, color);
  static var baseUrl = 'https://mesa-news-api.herokuapp.com';
  static var noticiasStream = new NoticiasStream();
  static var favoritos = [].obs;
}
