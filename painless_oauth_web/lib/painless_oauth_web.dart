import 'dart:async';
import 'dart:html';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';
import 'package:painless_oauth_web/src/widget/authorization_page.dart';

class PainlessOAuthPlugin extends PainlessOAuthPlatform {
  static void registerWith(Registrar registrar) {
    PainlessOAuthPlatform.instance = PainlessOAuthPlugin();
  }

  @override
  Widget authorizationPage({@required AuthorizationClient authorizationClient,
    Map<String, Object> platformSpecificOptions = const {}}) {
    print('in authorizationPage');
    return AuthorizationPage();
  }

  @override
  Future<Map<String, Object>> listenForResult() async {
    print('in listenForResult');
    return await Future.delayed(Duration(seconds: 100), () => {});
  }
}
