import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF29bf12),
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFABFF4F),
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);
