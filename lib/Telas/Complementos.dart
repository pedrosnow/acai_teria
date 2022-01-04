import 'dart:convert';

import 'package:acai_teria/Models/Complemento.dart';
import 'package:acai_teria/Telas/finalizacaoPedido.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Complementos extends StatefulWidget {
  int id;
  dynamic preco;
  String img;
  String produto;
  int qtdComplemento;
  int qtdComplementoComparacao;

  Complementos(this.id, this.preco, this.img, this.produto, this.qtdComplemento,
      this.qtdComplementoComparacao);

  @override
  _ComplementosState createState() => _ComplementosState();
}

class _ComplementosState extends State<Complementos> {
  bool _value = false;
  bool StatusBtn = true;
  List complemento = List();
  List ComplementoSelecionado = List();

  Future<List<Complemento>> _getComplemento() async {
    var url = Uri.parse('https://phdeveloper.online/api/complementos');
    var Shared = await SharedPreferences.getInstance();
    var tokenGet = Shared.get("Toke");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $tokenGet"
    };

    var response = await http.get(
      url,
      headers: header,
    );

    if (response.statusCode == 200 && complemento.length == 0) {
      for (var item in json.decode(response.body)) {
        Map<String, dynamic> dados = Map();
        dados['id_complemento'] = item['id_complemento'];
        dados['nome'] = item['nome'];
        if (item['boleano'] == 0) {
          dados['checked'] = false;
        }

        complemento.add(dados);
      }
    }
  }

  _complemento(id, value, nome) {
    Map<String, dynamic> selecionado = Map();
    if (value == true) {
      selecionado['id'] = id;
      selecionado['nome'] = nome;
      setState(() {
        ComplementoSelecionado.add(selecionado);
        widget.qtdComplemento = widget.qtdComplemento - 1;
      });
    } else {
      setState(() {
        ComplementoSelecionado.removeWhere((element) => element['id'] == id);
        widget.qtdComplemento = widget.qtdComplemento + 1;
      });
    }
    _verificarTamanhoArray();
  }

  _verificarTamanhoArray() {
    if (ComplementoSelecionado.length == widget.qtdComplementoComparacao) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => finalizacaoPedido(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(128, 65, 136, 1),
        title: Text("Complementos"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.36,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  FutureBuilder<List<Complemento>>(
                    future: _getComplemento(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.42,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colors.purple,
                                    strokeWidth: 6,
                                  ),
                                )
                              ],
                            ),
                          );
                          break;
                        case ConnectionState.active:
                        case ConnectionState.done:
                          return Container(
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.45,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: complemento.length,
                              // ignore: missing_return
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${complemento[index]['nome']}",
                                        style: TextStyle(
                                          fontSize: 19.sp,
                                        ),
                                      ),
                                      Checkbox(
                                        value: complemento[index]['checked'],
                                        onChanged: (bool value) {
                                          _complemento(
                                              complemento[index]
                                                  ['id_complemento'],
                                              value,
                                              complemento[index]['nome']);
                                          setState(() {
                                            complemento[index]['checked'] =
                                                value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                          break;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                color: Colors.grey.shade400,
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 1.1.h, left: 10),
                          width: 80,
                          child: Column(
                            children: [
                              Center(
                                child: FadeInImage.assetNetwork(
                                  placeholder: "img/load.gif",
                                  image:
                                      'http://acaiteria.phdeveloper.online/aplicacao/public/' +
                                          widget.img,
                                  width: 35,
                                ),
                              ),
                              Text(
                                widget.produto,
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total: ',
                                    style: TextStyle(
                                      fontSize: 4.w,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "R\$: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 4.w,
                                        ),
                                      ),
                                      Text(
                                        widget.preco.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 4.w,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Complementos disponivel: ',
                                      style: TextStyle(
                                        fontSize: 4.w,
                                      ),
                                    ),
                                    Text(
                                      widget.qtdComplemento.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 4.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
