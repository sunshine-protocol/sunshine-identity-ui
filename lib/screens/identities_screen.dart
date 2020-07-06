import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class IdentitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Identities'),
      body: _IdentitesScreenBody(),
    );
  }
}

class _IdentitesScreenBody extends StatelessWidget {
  const _IdentitesScreenBody({
    Key key,
  }) : super(key: key);
  final String _githubIdentity = 'shekohex';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListCell(
          title: 'Github',
          trailing: SizedBox(
            width: 80.w.toDouble(),
            child: HintText(_githubIdentity ?? 'N/A'),
          ),
          onTap: () {
            _showActions(context);
          },
        ),
      ],
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: 180.h.toDouble(),
          child: Column(
            children: [
              SizedBox(height: 5.h.toDouble()),
              Divider(
                thickness: 2,
                indent: ScreenUtil.screenWidth / 8,
                endIndent: ScreenUtil.screenWidth / 8,
                color: Colors.black54,
              ),
              SizedBox(height: 20.h.toDouble()),
              if (_githubIdentity != null) ...[
                Button(
                  text: 'View Proof',
                  variant: ButtonVariant.success,
                  onPressed: ExtendedNavigator.root.pop,
                ),
                SizedBox(height: 10.h.toDouble()),
                Button(
                  text: 'Revoke',
                  variant: ButtonVariant.danger,
                  onPressed: () {
                    ExtendedNavigator.root
                      ..pop()
                      ..pushRevokeIdentityScreen();
                  },
                )
              ] else ...[
                Button(
                  text: 'Prove',
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    ExtendedNavigator.root
                      ..pop()
                      ..pushProveIdentityScreen();
                  },
                ),
                SizedBox(height: 10.h.toDouble()),
                Button(
                  text: 'Cancel',
                  variant: ButtonVariant.secondry,
                  onPressed: ExtendedNavigator.root.pop,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class ProveIdentityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Identities'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText('Prove your Github identity'),
          SizedBox(height: 20.h.toDouble()),
          const Input(hintText: 'Github Username'),
          SizedBox(height: 5.h.toDouble()),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Next',
            variant: ButtonVariant.success,
            onPressed: () {
              ExtendedNavigator.root.pushProveIdentityInstractionsScreen();
            },
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }
}

class ProveIdentityInstractionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Github',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderText('Hey, shekohex'),
            SizedBox(height: 15.h.toDouble()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w.toDouble()),
              child: const HintText(
                'Login to your Github account and paste the text below'
                ' into a Public gist called substrate-identity-proof.md',
                maxLines: 4,
                softWrap: true,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 15.h.toDouble()),
            const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Input(
                initialValue: instractionsForDemo,
                maxLines: 16,
                readOnly: true,
              ),
            ),
            SizedBox(height: 24.h.toDouble()),
            Button(
              text: 'Copy to clipboard',
              variant: ButtonVariant.primary,
              onPressed: () {
                // TODO(shekohex): clipboard actions
              },
            ),
            SizedBox(height: 10.h.toDouble()),
            Button(
              text: 'OK posted, Check for it!',
              variant: ButtonVariant.success,
              onPressed: () {
                _checkIdentity(context);
              },
            ),
            SizedBox(height: 15.h.toDouble()),
          ],
        ),
      ),
    );
  }

  void _checkIdentity(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingView(
        loadingMessage: 'we are checking for your identity',
      ),
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        ExtendedNavigator.root
          ..popPages(1)
          ..pushProveIdentityDone();
      },
    );
  }
}

class ProveIdentityDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 120.h.toDouble()),
          const HeaderText('You successfully proved'),
          SizedBox(height: 30.h.toDouble()),
          const Input(
            hintText: 'shekohex@github',
            readOnly: true,
          ),
          SizedBox(height: 20.h.toDouble()),
          const HeaderText('and now part of your identity'),
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
                ..popPages(1)
                ..pushIdentitiesScreen();
            },
          ),
          SizedBox(height: 15.h.toDouble())
        ],
      ),
    );
  }
}

class RevokeIdentityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Identities'),
      body: Column(
        children: [
          SizedBox(height: 50.h.toDouble()),
          const HeaderText('Your are about to revoke'),
          SizedBox(height: 20.h.toDouble()),
          const Input(
            hintText: 'shekohex@github',
            readOnly: true,
          ),
          SizedBox(height: 40.h.toDouble()),
          const HeaderText('Are you sure?'),
          SizedBox(height: 20.h.toDouble()),
          const HintText('you can prove it again if you changed your mind'),
          const Expanded(child: SizedBox()),
          SizedBox(height: 20.h.toDouble()),
          Button(
            text: 'Yes, Revoke',
            variant: ButtonVariant.danger,
            onPressed: () {
              _revokeIdentity(context);
            },
          ),
          SizedBox(height: 10.h.toDouble()),
          Button(
            text: 'No, go back',
            variant: ButtonVariant.secondry,
            onPressed: ExtendedNavigator.root.pop,
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }

  void _revokeIdentity(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingView(
        loadingMessage: 'we are revoking this identity',
      ),
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        ExtendedNavigator.root
          ..popPages(1)
          ..pushRevokeIdentityDoneScreen();
      },
    );
  }
}

class RevokeIdentityDoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 120.h.toDouble()),
          const HeaderText('You successfully revoked'),
          SizedBox(height: 20.h.toDouble()),
          const Input(
            hintText: 'shekohex@github',
            readOnly: true,
          ),
          SizedBox(height: 20.h.toDouble()),
          const HeaderText('from your identities'),
          SizedBox(height: 40.h.toDouble()),
          const SunshineLogo(),
          const Expanded(child: SizedBox()),
          Button(
            text: 'Finish',
            variant: ButtonVariant.primary,
            onPressed: () {
              ExtendedNavigator.root
                ..popPages(1)
                ..pushIdentitiesScreen();
            },
          ),
          SizedBox(height: 15.h.toDouble()),
        ],
      ),
    );
  }
}

const instractionsForDemo = '''
### substrate identity proof

I hereby claim:

  * I am shekohex on github.
  * I am 0 on the substrate chain with genesis hash mzyTJZVm7IXDUBeZwyWk6rG1YGIt8BQnNzrshKJCalYI.
  * I have a public key 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY valid at block with hash mfBFseDYNX31Poqei8A/9teYmxJIj4PFROoKLKEPaStE.

To claim this, I am signing this object:

{"block":[124,17,108,120,54,13,95,125,79,162,167,162,240,15,253,181,230,38,196,146,35,224,241,81,58,130,139,40,67,218,74,209],"body":{"Ownership":[{"Github":["dvc94ch"]}]},"ctime":1591448931056,"expire_in":18446744073709551615,"genesis":[207,36,201,101,89,187,33,112,212,5,230,112,201,105,58,172,109,88,24,139,124,5,9,205,206,187,33,40,144,154,149,130],"prev":null,"public":"5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY","seqno":1,"uid":0}

with the key 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY, yielding the signature:

mAU6Gon1dqctnS/zPKHd9gWFvEJBqADvgYQy0OFuamA5CwVQk7papR0xBq8DijRqSXVGpJtNFmy7aYJk5cGLxv4c

And finally, I am proving ownership of the github account by posting this as a gist.
''';
