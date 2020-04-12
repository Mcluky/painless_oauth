import 'dart:async';
import 'dart:html';
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
    //todo add this key to documention
    bool useIframe = platformSpecificOptions['useIfame'] ?? false;
    Uri parametrizedAuthorizationUri = authorizationClient.parametrizedAuthorizationUri;
    if(useIframe){
      return AuthorizationPage(authorizationUri: parametrizedAuthorizationUri);
    }
    //String windowsFeature = 'menubar=no,toolbar=no';
    window.open(parametrizedAuthorizationUri.toString(), 'Painless_OAuth_Popup');
    return Text('Waiting...');
  }

  @override
  Future<Map<String, String>> listenForResult(AuthorizationClient authorizationClient) async {
    CallbackCapturerService callbackCapturerService = CallbackCapturerService();
    await callbackCapturerService.initialise();
    return callbackCapturerService.listenForResult();
  }
}
