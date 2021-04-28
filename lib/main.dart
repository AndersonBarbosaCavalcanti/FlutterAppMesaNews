
import 'package:mesa_news/config.dart';
import 'package:mesa_news/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mesa_news/TokenUsuario.dart';
import 'package:mesa_news/pages/index_page.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final tokenUsuario = new TokenUsuario();
  await tokenUsuario.initTokenUsuario();

  runApp(
    GetMaterialApp(
      theme: ThemeData(
        primaryColor: Config.colorCustom,
        accentColor: Config.colorCustom
      ),
      home: MyApp(), debugShowCheckedModeBanner: false
    )
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var tokenUsuario = new TokenUsuario();

    if(tokenUsuario.myFavoritos != 1) {

      for (var item in tokenUsuario.myFavoritos.split(',')) {
        
        Config.favoritos.add(item);
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Config.colorCustom,
        accentColor: Config.colorCustom
      ),
      title: 'Mesa News',
      home: tokenUsuario.myTOKEN == 1 ? IndexPage() : HomePage()
    );
  }
}