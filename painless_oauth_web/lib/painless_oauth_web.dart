import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';

class PainlessOAuthPlugin extends PainlessOAuthPlatform {
  static void registerWith(Registrar registrar) {
    PainlessOAuthPlatform.instance = PainlessOAuthPlugin();
  }

  @override
  Widget authorizationPage({@required AuthorizationClient authorizationClient,
    Map<String, Object> platformSpecificOptions = const {}}) {
    return Text('Hellllloooo');
  }

  @override
  Future<Map<String, Object>> listenForResult() async {
    return await Future.delayed(Duration(seconds: 100), () => {});
  }
}
