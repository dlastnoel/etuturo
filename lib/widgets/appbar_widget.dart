import 'package:flutter/material.dart';

appbarWidget(context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    flexibleSpace: Image(
      image: AssetImage('assets/images/head.png'),
      fit: BoxFit.fitWidth,
    ),
    leading: IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () => Navigator.pop(context),
      color: Colors.black,
    ),
  );
}
