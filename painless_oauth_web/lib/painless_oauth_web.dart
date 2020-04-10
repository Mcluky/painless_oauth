import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';
import 'package:painless_oauth_web/src/widget/authorization_page.dart';
import 'package:service_worker/worker.dart';
import 'package:service_worker/window.dart' as serviceWorkerHelper;

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
  Future<Map<String, Object>> listenForResult(Uri redirectUro) async {
    print('in listenForResult');
    if (serviceWorkerHelper.isNotSupported) {
      //todo offer support for browser that don't support the service worker api (with that I mean IE support)
      throw UnimplementedError('Ouch that\'s ironically painfull... The painless_oauth plugin does not yet work on '
          'browers without servier worker api support');
    }
    await serviceWorkerHelper.register(
        'assets/packages/painless_oauth_web/capturer/oauth_callback_capturer_service_worker.js',
        ServiceWorkerRegisterOptions(scope: '/assets/packages/painless_oauth_web/capturer/'));

    // Ensure that service worker is ready
    await serviceWorkerHelper.ready;

    serviceWorkerHelper.onMessage.listen((MessageEvent event) {
      print('reply received: ${event.data}');
    });

    return await Future.delayed(Duration(seconds: 100), () => {});
  }
}
