import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';
import 'package:painless_oauth_web/src/oauth/callback_capturer_service.dart';
import 'package:painless_oauth_web/src/widget/authorization_page.dart';

class PainlessOAuthPlugin extends PainlessOAuthPlatform {
  static void registerWith(Registrar registrar) {
    PainlessOAuthPlatform.instance = PainlessOAuthPlugin();
  }

  @override
  Widget authorizationPage(
      {@required AuthorizationClient authorizationClient, Map<String, Object> platformSpecificOptions = const {}}) {
    print('in authorizationPage');
    return AuthorizationPage();
  }

  @override
  Future<Map<String, Object>> listenForResult(AuthorizationClient authorizationClient) async {
    CallbackCapturerService callbackCapturerService = CallbackCapturerService();
    await callbackCapturerService.initialise();
    return callbackCapturerService.listenForResult();
  }
}
