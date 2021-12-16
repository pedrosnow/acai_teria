import 'dart:async';
import 'dart:convert';
import 'package:acai_teria/Components/Input.dart';
import 'package:acai_teria/Login.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'Components/alerta.dart';
import 'Models/Usuario.dart';

class Cadastro extends StatefulWidget {

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _whatsappController = TextEditingController();

  RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.stop();
    });
  }

  _validarCampos() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;
    String numero = _whatsappController.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty) {
        if (email.contains("@")) {
          if (senha.isNotEmpty) {
            if (senha.length > 6) {
              if (numero.isNotEmpty) {
                Usuario usuario = Usuario();
                usuario.nome = nome;
                usuario.email = email;
                usuario.password = senha;
                usuario.telefone = numero;

                _cadastrarUsuario(usuario);
              } else {
                alerta(
                  context,
                  'Ops..',
                  'Campo Whatsapp está vazio',
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
                'Senha não pode ser menor que que 6 caractere',
                CoolAlertType.info,
                Colors.blueGrey.shade100,
              );
              _btnController.error();
              _doSomething();
            }
          } else {
            alerta(
              context,
              'Ops..',
              'Campo senha está vazio',
              CoolAlertType.info,
              Colors.blueGrey.shade100,
            );
            _btnController.error();
            _doSomething();
          }
        } else {
          alerta(
            context,
            'Ops..',
            'Campo email precisa do @',
            CoolAlertType.info,
            Colors.blueGrey.shade100,
          );
          _btnController.error();
          _doSomething();
        }
      } else {
        alerta(
          context,
          'Ops..',
          'Campo email está fazio',
          CoolAlertType.info,
          Colors.blueGrey.shade100,
        );
        _btnController.error();
        _doSomething();
      }
    } else {
      alerta(
        context,
        'Ops..',
        'Campo nome está vazio',
        CoolAlertType.info,
        Colors.blueGrey.shade100,
      );
      _btnController.error();
      _doSomething();
    }
  }

  _cadastrarUsuario(Usuario usuario) async {
    // final Shared = await SharedPreferences.getInstance();
    var url = Uri.parse('https://phdeveloper.online/api/cadastrar');
    var header = {
      "Content-Type": "application/json",
    };

    Map params = {
      'nome': usuario.nome,
      'email': usuario.email,
      'password': usuario.password,
      'telefone': usuario.telefone,
    };

    var _body = jsonEncode(params);
    var response = await http.post(
      url,
      headers: header,
      body: _body,
    );

    int status = response.statusCode;

    dynamic retorno = json.decode(response.body)['status'];

    if (retorno == 'sucesso' && status == 200) {
      _btnController.success();
      Future.delayed(
        Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        },
      );
    } else {
      alerta(
        context,
        'Ops..',
        'Problema no servidor',
        CoolAlertType.error,
        Colors.blueGrey.shade100,
      );
      _btnController.error();
      _doSomething();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(239, 221, 255, 1),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'img/logo.PNG',
                      height: 30.h,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Cadastro',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[500],
                        fontFamily: 'Indie',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Input(
                          'Nome',
                          controller: _nomeController,
                          incone: Icons.perm_contact_cal_rounded,
                          keyboardType: TextInputType.name,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13),
                    child: Column(
                      children: [
                        Input(
                          'Email',
                          controller: _emailController,
                          incone: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13),
                    child: Column(
                      children: [
                        Input(
                          'Senha',
                          controller: _senhaController,
                          incone: Icons.vpn_key_sharp,
                          obscure: true,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13),
                    child: Column(
                      children: [
                        Input(
                          'Whatsapp',
                          controller: _whatsappController,
                          incone: Icons.phone,
                          keyboardType: TextInputType.number,
                        )
                      ],
                    ),
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
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ja tem conta? ",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 13.sp,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            "Loga-se aqui!",
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
                                builder: (context) => Login(),
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
          ),
        ),
      ),
    );
  }
}
