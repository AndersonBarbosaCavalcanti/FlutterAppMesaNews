
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news/api/loginApi.dart';
import 'package:mesa_news/config.dart';

class LoginPage extends StatelessWidget {

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {

            Get.back();
          },
          icon: Icon(Icons.close),
        ),
        title: Text('Login com e-mail'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/img/img1.png', color: Color(0xFF000634), width: 150),
              ],
            ),
          ),
          SizedBox(height: 40),
          Text('E-mail', style: TextStyle(color: Config.colorCustom, fontWeight: FontWeight.w500)),
          SizedBox(height: 6),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color(0xFFf0f0f0),
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),
          Text('Senha', style: TextStyle(color: Config.colorCustom, fontWeight: FontWeight.w500)),
          SizedBox(height: 6),
          TextField(
            controller: senhaController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color(0xFFf0f0f0),
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            ),
            obscureText: true,
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: RaisedButton(
              color: Config.colorCustom, textColor: Colors.white,
              onPressed: () {

                final email = emailController.text.trim();
                final senha = senhaController.text.trim();

                if(email == '' || senha == '') {

                  Get.rawSnackbar(message: 'Todos os campos são obrigatórios!');
                  return;
                }

                if(!GetUtils.isEmail(email)) {

                  Get.rawSnackbar(message: 'Digite um e-mail válido!');
                  return;
                }

                LoginApi.login(email, senha);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}