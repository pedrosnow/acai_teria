import 'dart:convert';

import 'package:acai_teria/Telas/Acai.dart';
import 'package:acai_teria/Telas/OutrosProdutos.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'Components/alerta.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _nome = "";
  var _email = "";

  int _selectedIndex = 0;
  static List<Widget> _WidgetOptions = <Widget>[
    Acai(),
    OutrosProdutos(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _sair() async {
    final Shared = await SharedPreferences.getInstance();
    final retorno = Shared.remove('Toke');
    final nome = Shared.remove("nome");
    final email = Shared.remove("email");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  _perfil() async {
    var url = Uri.parse('https://phdeveloper.online/api/perfil');
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

    int status = response.statusCode;
    dynamic retorno = json.decode(response.body);

    if (status == 200) {
      Shared.setInt("id", retorno["id"]);
      Shared.setString("nome", retorno["nome"]);
      Shared.setString("email", retorno["email"]);
      Shared.setString("telefone", retorno["telefone"]);
      _getDados();
    } else {
      alerta(
        context,
        'Ops..',
        'Tivemos problema em carregar seus dados',
        CoolAlertType.error,
        Colors.deepPurple.shade100,
      );
    }
  }

  _getDados() async {
    var Shared = await SharedPreferences.getInstance();

    setState(() {
      _nome = Shared.get("nome") as String;
      _email = Shared.get("email") as String;
    });
  }

  @override
  void initState() {
    _perfil();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acaí Teria'),
        backgroundColor: Color.fromRGBO(128, 65, 136, 1),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_nome),
              accountEmail: Text(_email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset("img/peril.png"),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(128, 65, 136, 1),
              ),
              otherAccountsPictures: [
                GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onTap: () {},
                )
              ],
            ),
            ListTile(
              onTap: _sair,
              leading: Icon(Icons.logout),
              title: Text('Sair'),
            )
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'img/fundo.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _WidgetOptions.elementAt(_selectedIndex)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.iceCream,
              size: 6.w,
            ),
            label: 'Acaí',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_pizza,
              size: 6.w,
            ),
            label: 'Outros Produtos',
            backgroundColor: Colors.amber,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromRGBO(128, 65, 136, 1),
      ),
    );
  }
}
