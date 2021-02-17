import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class PhoneEmailLinkLoginFormWidget extends StatelessWidget {
  final Function(String) onEmailLinkRequest;
  final Function(String) onCodeRequested;
  final Function() onGmailLoginRequested;
  final Function(String) onSnackBarRequested;

  final _emailController = TextEditingController();

  PhoneEmailLinkLoginFormWidget({
    this.onEmailLinkRequest,
    this.onCodeRequested,
    this.onGmailLoginRequested,
    this.onSnackBarRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Center(child: Image.asset('resources/images/logo.jpg'))),
        Form(
          child: Flex(
            direction: Axis.vertical,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: S.of(context).email),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: FlatButton(
                  color: Colors.transparent,
                  child: Text(S.of(context).sendLoginLink),
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      onSnackBarRequested(S.of(context).pleaseCompleteTheForm);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
