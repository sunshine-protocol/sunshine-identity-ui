import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

enum ButtonVariant { normal, thin, success, successThin }

class Button extends StatefulWidget {
  const Button({
    this.onPressed,
    this.text = 'Button',
    this.enabled = true,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.primary,
    this.variant = ButtonVariant.normal,
  });
  @override
  _ButtonState createState() => _ButtonState();
  final String text;
  final void Function() onPressed;
  final Color textColor;
  final Color backgroundColor;
  final bool enabled;
  final ButtonVariant variant;
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    const successBorderColor = Color.fromARGB(39, 2, 123, 101);
    const normalBorderColor = Color.fromARGB(39, 56, 73, 228);
    final isSuccess = widget.variant == ButtonVariant.success ||
        widget.variant == ButtonVariant.successThin;
    final isThin = widget.variant == ButtonVariant.thin ||
        widget.variant == ButtonVariant.successThin;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w.toDouble()),
      child: RaisedButton(
        padding: const EdgeInsets.all(0),
        onPressed: widget.enabled ? widget.onPressed : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            isThin ? 8.w.toDouble() : 10.w.toDouble(),
          ),
          side: BorderSide(
            color: isSuccess ? successBorderColor : normalBorderColor,
            width: 3,
          ),
        ),
        disabledColor: AppColors.disabled,
        child: Ink(
          height: isThin ? 39.h.toDouble() : 59.h.toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w.toDouble()),
            gradient: LinearGradient(
              colors: isSuccess
                  ? [const Color(0xFF40D0A5), AppColors.success]
                  : const [Color(0xFF68A4FF), Color(0xFF8995FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.visible,
              maxLines: 1,
              softWrap: false,
              textWidthBasis: TextWidthBasis.parent,
              style: TextStyle(
                color: widget.onPressed == null || !widget.enabled
                    ? Colors.black
                    : widget.textColor,
                fontSize: 16.ssp.toDouble(),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
