import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state.dart';

class GuideListStateLoading extends GuideListState {
  GuideListStateLoading(GuideListScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}