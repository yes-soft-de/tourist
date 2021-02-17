import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: S.of(context).email),
                ),
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
        GestureDetector(
          onTap: () {
            onGmailLoginRequested();
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FaIcon(
                FontAwesomeIcons.google,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
