import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:acai_teria/Cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'Components/Input.dart';
import 'Components/alerta.dart';
import 'Home.dart';
import 'Models/UserLogin.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:acai_teria/Models/UserLogin.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  _validarCampos() {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty) {
        UserLogin login = UserLogin();
        login.email = email;
        login.password = senha;
        _Logar(login);
      } else {
        alerta(
          context,
          'Ops..',
          'Senha está vazio',
          CoolAlertType.error,
          Colors.deepPurple.shade100,
        );
        _btnController.error();
        _doSomething();
      }
    } else {
      alerta(
        context,
        'Ops..',
        'Email está vazio',
        CoolAlertType.error,
        Colors.deepPurple.shade100,
      );
      _btnController.error();
      _doSomething();
    }
  }

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.stop();
    });
  }

  _Logar(UserLogin user) async {
    final Shared = await SharedPreferences.getInstance();
    var url = Uri.parse('https://phdeveloper.online/api/login');
    var header = {
      "Content-Type": "application/json",
    };
    Map params = {
      'email': user.email,
      'password': user.password,
    };
    var _body = jsonEncode(params);
    var response = await http.post(
      url,
      headers: header,
      body: _body,
    );

    int status = response.statusCode;

    dynamic token = json.decode(response.body)['access_token'];

    if (status == 200) {
      if (token != null) {
        _btnController.success();
        Shared.setString('Toke', token);
        Future.delayed(
          Duration(seconds: 1),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        );
      } else if (token == "Unauthorized") {
        alerta(
          context,
          'Ops..',
          'E-mail ou a senha está errado',
          CoolAlertType.error,
          Colors.blueGrey.shade100,
        );
        _doSomething();
      }
    } else if (status == 401) {
      _btnController.error();
      alerta(
        context,
        'Ops..',
        'E-mail ou a senha está errado',
        CoolAlertType.error,
        Colors.blueGrey.shade100,
      );
      _doSomething();
    } else if (status == 404) {
      _btnController.error();
      alerta(
        context,
        'Ops..',
        'Usuario não encontrado',
        CoolAlertType.error,
        Colors.blueGrey.shade100,
      );
      _doSomething();
    } else if (status == 500) {
      alerta(
        context,
        'Ops..',
        'Problema do servidor',
        CoolAlertType.error,
        Colors.blueGrey.shade100,
      );
      _btnController.error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'img/fundo.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: EdgeInsets.only(top: 66, right: 30, left: 30),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'img/logo.PNG',
                        height: 34.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Input('E-mail',
                            controller: _emailController, incone: Icons.mail),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Input('Senha',
                            obscure: true,
                            controller: _senhaController,
                            incone: Icons.vpn_key_sharp,
                            keyboardType: TextInputType.emailAddress),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: RoundedLoadingButton(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          controller: _btnController,
                          onPressed: _validarCampos,
                          resetAfterDuration: true,
                          color: Colors.purple,
                          successColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ainda não possui conta? ",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 13.sp,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            "Cadastre-se aqui!",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cadastro(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
