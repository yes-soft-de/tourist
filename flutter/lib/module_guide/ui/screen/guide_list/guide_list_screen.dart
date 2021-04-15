import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_guide/bloc/guide_list/guide_list_bloc.dart';
import 'package:tourists/module_guide/ui/states/guide_list_state.dart';

@provide
class GuideListScreen extends StatefulWidget {
  final GuideListBloc _guideListBloc;

  GuideListScreen(this._guideListBloc);

  void getGuides() {
    _guideListBloc.getAllGuides(this);
  }

  @override
  State<StatefulWidget> createState() => _GuideListScreenState();
}

class _GuideListScreenState extends State<GuideListScreen> {
  GuideListState currentStatus;

  StreamSubscription _stateSubscription;

  @override
  void initState() {
    _stateSubscription = widget._guideListBloc.guidesStream.listen((event) {
      currentStatus = event;
      if(mounted) {
        setState(() {});
      }
    });
    widget._guideListBloc.getAllGuides(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${S.of(context).soyah}'),
        backgroundColor: Colors.white,
      ),
      body: currentStatus != null ? currentStatus.getUI(context) : Container(),
    );
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      _stateSubscription.cancel();
    }
    super.dispose();
  }
}
