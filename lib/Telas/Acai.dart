import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:acai_teria/Models/ProdutoAcai.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'Complementos.dart';

class Acai extends StatefulWidget {
  @override
  _AcaiState createState() => _AcaiState();
}

class _AcaiState extends State<Acai> {
  Future<List<ProdutoAcai>> _getProdutoAcai() async {
    var url = Uri.parse('https://phdeveloper.online/api/acai');
    var Shared = await SharedPreferences.getInstance();
    var token_get = Shared.get("Toke");
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token_get"
    };

    var response = await http.get(
      url,
      headers: header,
    );

    List<ProdutoAcai> lista = List();

    for (var item in json.decode(response.body)) {
      ProdutoAcai produtos = ProdutoAcai();
      produtos.idProduto = item['id_produto'];
      produtos.produto = item['produto'];
      produtos.preco = item['preco'];
      produtos.img = item['img'];
      produtos.quantidadeComplemento = item['quantidade_complemento'];
      lista.add(produtos);
    }

    return lista;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProdutoAcai>>(
      future: _getProdutoAcai(),
      // ignore: missing_return
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: .59,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) {
                  List<ProdutoAcai> listaItem = snapshot.data;
                  ProdutoAcai produtoAcai = listaItem[index];
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(128, 65, 136, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "img/load.gif",
                                  image:
                                      'http://acaiteria.phdeveloper.online/aplicacao/public/' +
                                          produtoAcai.img,
                                  width: 20.w,
                                  height: 17.h,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      produtoAcai.produto,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "R\$: " + produtoAcai.preco.toString(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Complementos(
                                          produtoAcai.idProduto,
                                          produtoAcai.preco,
                                          produtoAcai.img,
                                          produtoAcai.produto,
                                          produtoAcai.quantidadeComplemento,
                                          produtoAcai.quantidadeComplemento),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Pedir',
                                  style: TextStyle(
                                    fontSize: 4.w,
                                    fontFamily: 'arial',
                                    color: Color.fromRGBO(128, 65, 136, 1),
                                  ),
                                ),
                                color: Color.fromRGBO(239, 221, 255, 1),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
            break;
        }
      },
    );
  }
}
