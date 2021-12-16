import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  List dados;

  Teste(this.dados);

  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  void initState() {
    print(widget.dados);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
