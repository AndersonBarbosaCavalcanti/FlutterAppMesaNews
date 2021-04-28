import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:mesa_news/TokenUsuario.dart';
import 'package:mesa_news/config.dart';
import 'package:mesa_news/models/noticia_model.dart';

class NoticiaPage extends StatelessWidget {

  final NoticiaModel noticia;

  NoticiaPage(this.noticia);

  @override
  Widget build(BuildContext context) {

    final t = new TokenUsuario();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Config.colorCustom,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {

            Get.back();
          },
        ),
        title: Column(
          children: [
            Text(noticia.title, style: TextStyle(fontSize: 13)),
            Text('${Uri.parse(noticia.url).host}', style: TextStyle(fontSize: 10)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {

              if(Config.favoritos.contains(noticia.url) == false) {

                Config.favoritos.add(noticia.url);
                t.myFavoritos = Config.favoritos.join(',');
              } else {

                for (var i = 0; i < Config.favoritos.length; i++) {
                  
                  if(Config.favoritos[i] == noticia.url) {

                    Config.favoritos.removeAt(i);
                  }
                }

                t.myFavoritos = Config.favoritos.join(',');
                Config.favoritos.add('');
                Config.favoritos.removeAt(Config.favoritos.length - 1);
              }
            },
            icon: Obx(() => Config.favoritos.contains(noticia.url) == false ? Icon(Icons.bookmark_outline_rounded):  Icon(Icons.bookmark_outlined)),
          )
        ],
      ),
      body: InAppWebView(
        initialUrl: noticia.url
      )
    );
  }
}