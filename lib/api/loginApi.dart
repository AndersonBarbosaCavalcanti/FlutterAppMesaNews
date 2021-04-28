import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mesa_news/TokenUsuario.dart';
import 'package:mesa_news/config.dart';
import 'package:mesa_news/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginApi {

  static login(email, senha) async {

    bool result = await DataConnectionChecker().hasConnection;
    if(result == false) {
      
      Get.rawSnackbar(message: 'Você não está conectado a internet!');
      return;
    }

    Get.defaultDialog(
      title: 'Carregando...',
      content: CircularProgressIndicator(),
      barrierDismissible: false
    );

    final t = new TokenUsuario();

    var response = await http.post(Config.baseUrl+'/v1/client/auth/signin', body: {"email": email,"password": senha});

    Get.back();

    if(response.body.split('token').length > 1) {

      final dados = json.decode(response.body);
      t.myTOKEN = dados['token'];

      Get.offAll(() => HomePage());
    } else if(response.body.split('INVALID_CREDENTIALS').length > 1) {

      Get.rawSnackbar(message: 'E-mail e/ou senha incorretos!');
    } else {

      Get.rawSnackbar(message: 'Falha ao se comunicar com o servidor!');
    }
  }
}