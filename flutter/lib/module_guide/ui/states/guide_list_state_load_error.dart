import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state.dart';

class GuideListStateLoadError extends GuideListState {
  String errorMsg;

  GuideListStateLoadError(GuideListScreen screen, this.errorMsg)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.not_interested,color: Colors.red,size: 125,),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text('${errorMsg=='Empty List'?S.of(context).empty:errorMsg}',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),)),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: RaisedButton(
              child: Text('${S.of(context).reload}'),
              onPressed: () {
                screen.getGuides();
              },
            ),
          ),
        )
      ],
    );
  }
}
