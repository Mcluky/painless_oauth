import 'package:flutter/material.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_web/src/oauth/window_tab_manager.dart';
import 'package:painless_oauth_web/src/widget/demand_user_login.dart';

class PopUpAuthorizationPage extends StatefulWidget {
  final AuthorizationClient authorizationClient;

  PopUpAuthorizationPage({@required this.authorizationClient});

  @override
  _PopUpAuthorizationPageState createState() => _PopUpAuthorizationPageState();
}

class _PopUpAuthorizationPageState extends State<PopUpAuthorizationPage> {
  WindowTabManager _windowTabManager;

  @override
  void initState() {
    _windowTabManager = new WindowTabManager();
    _windowTabManager.openInPopup(widget.authorizationClient);
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
