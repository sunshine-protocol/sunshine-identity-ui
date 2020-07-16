import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identity/identity.dart';
import 'package:identity/models/models.dart';

class AccountScreen extends StatelessWidget {
  final _accountService = GetIt.I.get<AccountService>();
  final _walletService = GetIt.I.get<WalletService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Account', elevation: 1),
      body: ListView(
        children: [
          const HeaderText('Your Information'),
          SizedBox(height: 15.w.toDouble()),
          const HintText('Tip: long press to copy to clipboard'),
          SizedBox(height: 10.w.toDouble()),
          ListCell(
            title: 'UID',
            trailing: SizedBox(
              width: 60.w.toDouble(),
              child: FutureBuilder<String>(
                initialData: '...',
                future: _accountService.uid(),
                builder: (context, snapshot) {
                  return HintText(
                    snapshot.data ?? 'N/A',
                  );
                },
              ),
            ),
            onLongPress: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: await _accountService.uid(),
                ),
              );
            },
          ),
          ListCell(
            title: 'Device ID',
            trailing: SizedBox(
              width: 120.w.toDouble(),
              child: FutureBuilder<Device>(
                initialData: const Device(
                  id: '...',
                  currentDevice: true,
                ),
                future: _accountService.currentDevice(),
                builder: (context, snapshot) => HintText(
                  snapshot.data?.id ?? 'N/A',
                ),
              ),
            ),
            onLongPress: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: (await _accountService.currentDevice()).id,
                ),
              );
            },
          ),
          ListCell(
            title: 'Balance',
            trailing: SizedBox(
              width: 120.w.toDouble(),
              child: FutureBuilder<String>(
                initialData: '...',
                future: _walletService.balance(),
                builder: (context, snapshot) {
                  return HintText(
                    '☼${snapshot.data}' ?? 'N/A',
                  );
                },
              ),
            ),
            onTap: () async {
              try {
                await _walletService.mint();
              } catch (_) {
                // don't do anything, it is only for testing ..
              }
            },
            onLongPress: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: await _walletService.balance(),
                ),
              );
            },
          ),
          SizedBox(height: 20.w.toDouble()),
          const HeaderText('Profile'),
          SizedBox(height: 10.w.toDouble()),
          ListCell(
            title: 'Devices',
            trailing: Icon(Icons.chevron_right, size: 40),
            onTap: () {
              ExtendedNavigator.root.pushDevicesScreen();
            },
          ),
          ListCell(
            title: 'Identities',
            trailing: Icon(Icons.chevron_right, size: 40),
            onTap: () {
              ExtendedNavigator.root.pushIdentitiesScreen();
            },
          ),
          SizedBox(height: 20.w.toDouble()),
          const HeaderText('Legal'),
          SizedBox(height: 10.w.toDouble()),
          ListCell(
            title: 'About',
            trailing: Icon(Icons.chevron_right, size: 40),
          ),
        ],
      ),
    );
  }
}
