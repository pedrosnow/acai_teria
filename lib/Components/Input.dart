import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Input(String hint, {bool obscure = false, controller, incone, keyboardType}) {
  return Container(
    padding: EdgeInsets.only(right: 10, left: 10, bottom: 0),
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 0.600),
      borderRadius: BorderRadius.circular(32),
    ),
    child: TextField(
      keyboardType: keyboardType,
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 14.sp,
        ),
        hintText: hint,
        suffixIcon: Icon(
          incone,
          color: Colors.purple,
          size: 18.sp,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 20, top: 13),
      ),
    ),
  );
}
