import 'dart:async';
import 'dart:html';
import 'package:service_worker/window.dart' as serviceWorkerHelper;
import 'package:service_worker/worker.dart';

class CallbackCapturerService {
  /// Initialises/registers the oauth callback capturer service worker
  Future<void> initialise() async {
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
  }

  /// Listen for the callback
  Future<Map<String, String>> listenForResult() {
    Completer<Map<String, String>> completer = Completer();
    //listen for response from service worker
    BroadcastChannel oauthCallbackChannel = BroadcastChannel('oauth_callback');
    oauthCallbackChannel.onMessage.first.then((event) {
      String callbackUrl = event.data;
      Map<String, String> parameters = parseCallbackUrlToParameters(callbackUrl);
      oauthCallbackChannel.close();
      completer.complete(parameters);
    });
    return completer.future;
  }

  Map<String, String> parseCallbackUrlToParameters(String callbackUrl){
    Uri callbackUri = Uri.parse(callbackUrl);
    // According to the oauth rfc (https://tools.ietf.org/html/rfc6749#section-4.2.2) the parameters are passed
    // inside the url fragment (E.g: "http://example.com/callback#access_token=132&...
    Uri parameterUri = Uri(query: callbackUri.fragment);
    Map<String, String> queryParameters = parameterUri.queryParameters;
    return queryParameters;
  }
}
