import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';
import 'package:painless_oauth_web/src/oauth/callback_capturer_service.dart';
import 'package:painless_oauth_web/src/oauth/web_authorization_component.dart';
import 'package:painless_oauth_web/src/widget/iframe_authorization_page.dart';
import 'package:painless_oauth_web/src/widget/pop_up_authorization_page.dart';
import 'package:painless_oauth_web/src/widget/tab_authorization_page.dart';

class PainlessOAuthPlugin extends PainlessOAuthPlatform {
  static void registerWith(Registrar registrar) {
    PainlessOAuthPlatform.instance = PainlessOAuthPlugin();
  }

  @override
  Widget authorizationPage(
      {@required AuthorizationClient authorizationClient, Map<String, Object> platformSpecificOptions = const {}}) {
    //todo add this key to documention
    String webAuthorizationComponentName = platformSpecificOptions['web.useComponent'] ?? 'popUp';
    WebAuthorizationComponent webAuthorizationComponent = WebAuthorizationComponent(webAuthorizationComponentName);
    assert(webAuthorizationComponent == WebAuthorizationComponent.popUp ||
            webAuthorizationComponent == WebAuthorizationComponent.tab ||
            webAuthorizationComponent == WebAuthorizationComponent.iframe,
        'The platformspecific option \'web.useComponent\' with value \'$webAuthorizationComponentName\' does not exist');

    if (webAuthorizationComponent == WebAuthorizationComponent.tab) {
      return TabAuthorizationPage(authorizationClient: authorizationClient);
    } else if(webAuthorizationComponent == WebAuthorizationComponent.iframe){
      return IframeAuthorizationPage(authorizationClient: authorizationClient);
    } else {
      // Default to popUp on prod build if other web component not available
      return PopUpAuthorizationPage(authorizationClient: authorizationClient);
    }
  }

  @override
  Future<Map<String, String>> listenForResult(AuthorizationClient authorizationClient) async {
    CallbackCapturerService callbackCapturerService = CallbackCapturerService();
    await callbackCapturerService.initialise();
    return callbackCapturerService.listenForResult();
  }
}
