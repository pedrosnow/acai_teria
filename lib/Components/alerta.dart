import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

alerta(BuildContext context, String title, String text, tipo, color) {
  CoolAlert.show(
    context: context,
    type: tipo,
    title: title,
    text: text,
    loopAnimation: false,
    barrierDismissible: false,
    backgroundColor: color,
  );
}
