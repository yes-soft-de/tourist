import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state.dart';

class GuideListStateLoadError extends GuideListState {
  String errorMsg;

  GuideListStateLoadError(GuideListScreen screen, this.errorMsg)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Text('${errorMsg}'),
        RaisedButton(
          onPressed: () {
            screen.getGuides();
          },
        )
      ],
    );
  }
}
