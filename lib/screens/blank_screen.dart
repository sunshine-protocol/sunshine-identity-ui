import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class BlankScreen extends StatefulWidget {
  @override
  _BlankScreenState createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375,
      height: 812,
      allowFontScaling: true,
    );
    return const Scaffold(
      body: Center(
        child: SunshineLogo(),
      ),
    );
  }
}
