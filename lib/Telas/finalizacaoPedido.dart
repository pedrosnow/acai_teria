import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FinalizacaoPedido extends StatefulWidget {
  @override
  _FinalizacaoPedidoState createState() => _FinalizacaoPedidoState();
}

class _FinalizacaoPedidoState extends State<FinalizacaoPedido> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(128, 65, 136, 1),
        title: Text("Finalização do Pedido"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pedido',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.h,
                      ),
                    ),
                    Text(
                      '#01',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.h,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Row(
                          children: [
                            Text(
                              'Produto',
                              style: TextStyle(
                                fontSize: 2.5.h,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("x1"),
                          Text("Açaí 200ML"),
                          Text("R\$: 10,0"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: Row(
                          children: [
                            Text(
                              'Complementos',
                              style: TextStyle(
                                fontSize: 2.5.h,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.circle,
                                    size: 10,
                                  ),
                                ),
                                Text(
                                  "Creme de Orion",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.circle,
                                    size: 10,
                                  ),
                                ),
                                Text(
                                  "Amendoin",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.circle,
                                    size: 10,
                                  ),
                                ),
                                Text(
                                  "Gotas de chocolate",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.circle,
                                    size: 10,
                                  ),
                                ),
                                Text(
                                  "Granola",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
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
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forma de Pagamento',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.h,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: [],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
