import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375,
      height: 812,
      allowFontScaling: true,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 280.h.toDouble()),
          SunshineLogo(
            height: 150.h.toDouble(),
            width: 150.w.toDouble(),
          ),
          SizedBox(height: 15.h.toDouble()),
          Text(
            'Join Sunshine',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 26.ssp.toDouble(),
            ),
          ),
          SizedBox(height: 145.h.toDouble()),
          Button(
            variant: ButtonVariant.success,
            text: 'Generate Account',
            onPressed: () {
              // step one: Device name, we skip that for now.
              ExtendedNavigator.root.pushGenerateAccountStepTwoScreen();
            },
          ),
          SizedBox(height: 20.h.toDouble()),
          Button(
            variant: ButtonVariant.primary,
            text: 'Restore my account',
            onPressed: () {
              ExtendedNavigator.root.pushRecoverAccountStepOneScreen();
            },
          )
        ],
      ),
    );
  }
}
