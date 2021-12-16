import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Btn(Function func, String texto) {
  return RaisedButton(
    onPressed: () {
      func();
    },
    padding: EdgeInsets.all(13),
    color: Colors.purple,
    // Arredondar a borda do buttom
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),
    ),
    child: Text(
      texto,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
      ),
    ),
  );
}
