import 'package:flutter/material.dart';
import 'package:test_app/gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: const GrandientContainer(Color.fromARGB(255, 129, 129, 129), Color.fromARGB(255, 82, 82, 82)),
      ),
    ),
  );
}

