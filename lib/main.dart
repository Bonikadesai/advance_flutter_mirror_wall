import 'package:flutter/material.dart';
import 'package:mirror_wall/home_page.dart';
import 'package:mirror_wall/provider/connect_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ConnectProvider(),
      ),
    ],
    builder: (context, child) => MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}
