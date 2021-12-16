import 'package:acai_teria/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  _verificarUsuario() async {
    final Shared = await SharedPreferences.getInstance();
    final toke = Shared.getString('Toke');

    Future.delayed(Duration(milliseconds: 1200), () {
      if (toke == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
  }

  void initState() {
    _verificarUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'img/fundo.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Center(
                  child: Image.asset(
                    'img/logo.PNG',
                    width: 260,
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: Colors.purple,
                  strokeWidth: 6,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
