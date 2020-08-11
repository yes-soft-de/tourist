import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/guide_list_module/bloc/guide_list/guide_list_bloc.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/nav_arguments/request_guide/request_guide_navigation.dart';
import 'package:tourists/ui/widgets/guide_list_item/guide_list_item.dart';
import 'package:tourists/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';

@provide
class TouristGuideListSubScreen extends StatefulWidget {

  final RequestGuideScreen _requestGuideScreen;

  TouristGuideListSubScreen(this._guideListBloc, this._requestGuideScreen);

  @override
  State<StatefulWidget> createState() => _TouristGuideListSubScreenState();
}

class _TouristGuideListSubScreenState extends State<TouristGuideListSubScreen> {

}
