import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mesa_news/TokenUsuario.dart';
import 'package:mesa_news/config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NoticiasApi {

  static getNews(currentPage) async {

    bool result = await DataConnectionChecker().hasConnection;
    if(result == false) {
      
      Config.noticiasStream.addData('connectionError');
      return;
    }

    final t = new TokenUsuario();

    final headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${t.myTOKEN}'
    };

    var response = await http.get(Config.baseUrl+'/v1/client/news?current_page=$currentPage&per_page=20', headers: headers);

    Get.back();

    if(response.body.split('pagination').length > 1) {

      final dados = json.decode(response.body);

      Config.noticiasStream.addData(dados);
      return dados;
    } else {

      Config.noticiasStream.addData('error');
      return;
    }
  }
}