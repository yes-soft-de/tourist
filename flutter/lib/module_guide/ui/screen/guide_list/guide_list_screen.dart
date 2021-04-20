import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String guideLanguage;
  TextEditingController cityController;
  StreamSubscription _stateSubscription;

  @override
  void initState() {
    cityController = TextEditingController();
    _stateSubscription = widget._guideListBloc.guidesStream.listen((event) {
      currentStatus = event;
      if (mounted) {
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
        actions: [
          IconButton(
            splashRadius: 25,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('${S.of(context).filter}'),
                      content: Container(
                        height: 175,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: DropdownButtonFormField(
                                value: guideLanguage ?? null,
                                items: ['ar', 'en'].map((guideLanguage) {
                                  return DropdownMenuItem(
                                    value: guideLanguage,
                                    child: Text(guideLanguage),
                                  );
                                }).toList(),
                                hint: Text(S.of(context).language),
                                onChanged: (String value) {
                                  guideLanguage = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextField(
                                controller: cityController,
                                decoration: InputDecoration(
                                    labelText: '${S.of(context).targetCity}'),
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            widget._guideListBloc.getAllGuidesFiltred(
                                widget,
                                guideLanguage ?? null,
                                cityController.text == ''
                                    ? null
                                    : cityController.text);
                            Navigator.of(context).pop();
                          },
                          child: Text('${S.of(context).continues}'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('${S.of(context).cancel}'),
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.filter_list),
          ),
          cityController.text.isNotEmpty || guideLanguage !=null ? IconButton(
            splashRadius: 25,
            onPressed: () {
              guideLanguage = null;
              cityController.clear();
               widget._guideListBloc.getAllGuides(widget);
            },
            icon: Icon(Icons.clear),
          ):Container(),
        ],
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
