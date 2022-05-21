import 'package:flutter/material.dart';

AppBar buildAppBar(Container extra) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 50,
        ),
        extra,
      ],
    ),
  );
}
