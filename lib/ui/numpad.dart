import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class Numpad extends StatefulWidget {
  const Numpad({Key key, this.length = 20, this.onChange}) : super(key: key);
  final int length;
  final void Function(String) onChange;
  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  String number = '';

  void setValue(String val) {
    if (number.length < widget.length) {
      setState(() {
        number += val;
        widget.onChange(number);
      });
    }
  }

  void backspace(String text) {
    if (text.isNotEmpty) {
      setState(() {
        number = text.substring(0, text.length - 1);
        widget.onChange(number);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumpadButton(
                text: '1',
                onPressed: () => setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: () => setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: () => setValue('3'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumpadButton(
                text: '4',
                onPressed: () => setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: () => setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: () => setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumpadButton(
                text: '7',
                onPressed: () => setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: () => setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: () => setValue('9'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const NumpadButton(),
              NumpadButton(
                text: '0',
                onPressed: () => setValue('0'),
              ),
              NumpadButton(
                icon: Icons.backspace,
                onPressed: () => backspace(number),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NumpadButton extends StatelessWidget {
  const NumpadButton({Key key, this.text, this.icon, this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextStyle(
      fontSize: 35.ssp.toDouble(),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    final label = icon != null
        ? Icon(
            icon,
            color: Colors.black,
            size: 35,
          )
        : Text(text ?? '', style: buttonStyle);

    return Padding(
      padding: EdgeInsets.all(10.w.toDouble()),
      child: Container(
        child: OutlineButton(
          borderSide: BorderSide.none,
          splashColor: Colors.transparent,
          onPressed: onPressed,
          child: label,
        ),
      ),
    );
  }
}
