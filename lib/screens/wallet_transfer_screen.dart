import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class WalletTransferScreen extends StatefulWidget {
  const WalletTransferScreen(this.amount);

  final String amount;

  @override
  _WalletTransferScreenState createState() => _WalletTransferScreenState();
}

class _WalletTransferScreenState extends State<WalletTransferScreen> {
  TextEditingController _idController;
  String _errText;
  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Transfer'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText('Transfer Tokens from your wallet'),
          SizedBox(height: 20.h.toDouble()),
          Padding(
            padding: EdgeInsets.only(left: 25.w.toDouble()),
            child: const HintText('Who you want to send these tokens?'),
          ),
          SizedBox(height: 20.h.toDouble()),
          Input(
            hintText: 'UID or Username',
            controller: _idController,
            errorText: _errText,
            onChanged: (_) {
              if (_errText != null) {
                _errText = null;
              }
            },
          ),
          SizedBox(height: 10.h.toDouble()),
          const Expanded(
            child: SizedBox(),
          ),
          Button(
            text: 'Next',
            variant: ButtonVariant.success,
            onPressed: () {
              if (_idController.text.isEmpty) {
                setState(() {
                  _errText = 'Please enter the UID';
                });
              }
              ExtendedNavigator.root.pushWalletTransferConfirmationScreen(
                amount: widget.amount,
                id: _idController.text,
              );
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}

class WalletTransferConfirmationScreen extends StatefulWidget {
  const WalletTransferConfirmationScreen(this.id, this.amount);

  final String amount;
  final String id;

  @override
  _WalletTransferConfirmationScreenState createState() =>
      _WalletTransferConfirmationScreenState();
}

class _WalletTransferConfirmationScreenState
    extends State<WalletTransferConfirmationScreen> {
  WalletService _walletService;
  @override
  void initState() {
    super.initState();
    _walletService = GetIt.I.get<WalletService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Transfer'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h.toDouble()),
          const Center(child: HeaderText('You are about to transfer')),
          SizedBox(height: 30.h.toDouble()),
          _TransferTokensValue(tokens: widget.amount),
          SizedBox(height: 12.h.toDouble()),
          const Center(child: HintText('Tokens')),
          SizedBox(height: 30.h.toDouble()),
          Center(child: HeaderText('To ${widget.id}')),
          SizedBox(height: 30.h.toDouble()),
          const Center(
            child: HintText('There is no way to reverse this'),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Button(
            text: 'Transfer',
            variant: ButtonVariant.success,
            onPressed: _walletTransfer,
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }

  Future<void> _walletTransfer() async {
    // ignore: unawaited_futures
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingView(
        loadingMessage: 'we are sending ${widget.amount} tokens',
      ),
    );
    await _walletService.transfer(
      widget.id,
      int.parse(widget.amount),
    );
    await Future.delayed(
      const Duration(milliseconds: 100),
      () {
        ExtendedNavigator.root
          ..popPages(2)
          ..pushWalletTransferDoneScreen(
            id: widget.id,
            amount: widget.amount,
          );
      },
    );
  }
}

class _TransferTokensValue extends StatelessWidget {
  const _TransferTokensValue({
    @required String tokens,
    Key key,
  })  : _tokens = tokens,
        super(key: key);

  final String _tokens;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w.toDouble()),
        child: FittedBox(
          child: Text(
            '☼$_tokens',
            style: TextStyle(
              fontSize: 42.ssp.toDouble(),
              fontWeight: FontWeight.w900,
              color: AppColors.success,
            ),
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class WalletTransferDoneScreen extends StatelessWidget {
  const WalletTransferDoneScreen(this.id, this.amount);
  final String amount;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100.h.toDouble()),
          const Center(child: HeaderText('You successfully sent')),
          SizedBox(height: 30.h.toDouble()),
          _TransferTokensValue(tokens: amount),
          SizedBox(height: 30.h.toDouble()),
          Center(child: HeaderText('tokens to $id')),
          SizedBox(height: 30.h.toDouble()),
          const SunshineLogo(),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Button(
            text: 'Finish',
            variant: ButtonVariant.primary,
            onPressed: () {
              ExtendedNavigator.root
                ..popPages(2)
                ..pushMainScreen();
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}
