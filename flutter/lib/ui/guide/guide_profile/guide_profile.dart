import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class GuideProfileScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _GuideProfileScreenState();
}

class _GuideProfileScreenState extends State<GuideProfileScreen> {
  int step = 0;
  PageController _profilePagesController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _profilePagesController,
        children: <Widget>[
          Column(
            // TODO: Create Profile Screen Here
          ),
          Column(
            // TODO: Attach to Cities here?!!
          )
        ],
      ),
    );
  }
}
