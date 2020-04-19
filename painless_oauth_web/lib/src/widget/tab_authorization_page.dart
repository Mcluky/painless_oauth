import 'package:flutter/material.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_web/src/oauth/window_tab_manager.dart';

import 'demand_user_login.dart';

class TabAuthorizationPage extends StatefulWidget {
  final AuthorizationClient authorizationClient;

  TabAuthorizationPage({@required this.authorizationClient});

  @override
  _TabAuthorizationPageState createState() => _TabAuthorizationPageState();
}

class _TabAuthorizationPageState extends State<TabAuthorizationPage> {
  WindowTabManager _windowTabManager;

  @override
  void initState() {
    _windowTabManager = new WindowTabManager();
    _windowTabManager.openInNewTab(widget.authorizationClient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DemandUserLogin();
  }

  @override
  void dispose() {
    _windowTabManager.closeActiveWindow();
    super.dispose();
  }
}
