import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(String text) : _text = text;
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w.toDouble(),
        top: 10.h.toDouble(),
        right: 24.w.toDouble(),
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          _text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.ssp.toDouble(),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
