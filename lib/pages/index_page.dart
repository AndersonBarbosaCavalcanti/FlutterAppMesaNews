
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/config.dart';
import 'package:mesa_news/pages/login_page.dart';

class IndexPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Config.colorCustom,
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('lib/assets/img/logo2.png',scale: 4),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: RaisedButton(
                textColor: Color(0xFF0075FF),
                color: Colors.white,
                onPressed: () {

                  Get.to(() => LoginPage());
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text('Entrar com e-mail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}