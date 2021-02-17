import 'package:flutter/material.dart';
import 'package:tourists/module_guide/ui/screen/guide_list/guide_list_screen.dart';

abstract class GuideListState {
  GuideListScreen screen;
  GuideListState(this.screen);
  Widget getUI(BuildContext context);
}