
import 'package:intl/intl.dart';
import 'package:mesa_news/TokenUsuario.dart';
import 'package:mesa_news/api/noticiasApi.dart';
import 'package:mesa_news/models/noticia_model.dart';
import 'package:flutter/material.dart';
import 'package:mesa_news/config.dart';
import 'package:get/get.dart';
import 'package:mesa_news/pages/noticia_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var currentPage = 1;
  List<NoticiaModel> noticias = new List();
  final t = new TokenUsuario();

  @override
  void initState() { 
    super.initState();
    
    getNoticias();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Config.colorCustom,
        centerTitle: true,
        title: Text('Mesa News')
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: Config.noticiasStream.output,
        builder: (context, snapshot) {

          if(!snapshot.hasData) {

            return Center(child: CircularProgressIndicator());
          }

          final dados = snapshot.data;

          if(dados == 'connectionError') {

            return ErrorWidget('Você não está conectado a internet!');
          } else if(dados == 'error') {

            return ErrorWidget('Falha ao se comunicar com o servidor!');
          }
          
          return ListView.builder(
            itemCount: noticias.length,
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {

              if(index == noticias.length - 1) {
                
                currentPage++;
                getNoticias();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index == 0 ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Últimas notícias', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      SizedBox(height: 20),
                    ],
                  ) : SizedBox(),
                  NoticiaWidget(noticias[index]),
                  
                  index == noticias.length - 1 ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator()
                      ],
                    ),
                  ) : SizedBox()
                ],
              );
            }
          );
        }
      )
    );
  }

  getNoticias() async {

    final dados = await NoticiasApi.getNews(currentPage);

    if(dados == null) return;

    for (var item in dados['data']) {
      
      final noticia = new NoticiaModel.fromJsonMap(item);

      noticias.add(noticia);
    }
  }
}

class NoticiaWidget extends StatelessWidget {

  final NoticiaModel item;

  NoticiaWidget(this.item);

  @override
  Widget build(BuildContext context) {

    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(item.publishedAt);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    return InkWell(
      onTap: () {
        
        Get.to(() => NoticiaPage(item));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.width - 32) / 2.3,
              child: Image.network(item.imageUrl, fit: BoxFit.cover)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 30,
                child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {

                    final t = new TokenUsuario();

                    if(Config.favoritos.contains(item.url) == false) {

                      Config.favoritos.add(item.url);
                      t.myFavoritos = Config.favoritos.join(',');
                    } else {

                      for (var i = 0; i < Config.favoritos.length; i++) {
                        
                        if(Config.favoritos[i] == item.url) {

                          Config.favoritos.removeAt(i);
                        }
                      }

                      t.myFavoritos = Config.favoritos.join(',');
                      Config.favoritos.add('');
                      Config.favoritos.removeAt(Config.favoritos.length - 1);
                    }
                  },
                  icon: Obx(() => Config.favoritos.contains(item.url) == false ? 
                    Icon(Icons.bookmark_outline_rounded):  Icon(Icons.bookmark_outlined)
                  )
                ),
              ),
              Text(outputDate, style: Theme.of(context).textTheme.bodyText1.copyWith(fontStyle: FontStyle.italic))
            ],
          ),
          Text('${item.title}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          SizedBox(height: 6),
          Text('${item.description}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13)),
          Divider(color: Colors.grey, height: 30)
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  
  final msg;

  ErrorWidget(this.msg);

  @override
  Widget build(BuildContext context) {

    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$msg'),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Config.colorCustom, textColor: Colors.white,
              onPressed: () {

                Get.offAll(() => HomePage());
              },
              child: Row(
                children: [
                  Icon(Icons.refresh, size: 18),
                  SizedBox(width: 6),
                  Text('Recarregar'),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}