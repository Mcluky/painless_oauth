import 'dart:async';
import 'dart:html';
import 'package:service_worker/window.dart' as serviceWorkerHelper;
import 'package:service_worker/worker.dart';

class CallbackCapturerService{
  /// Initialises/registers the oauth callback capturer service worker
  Future<void> initialise() async{
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
  Future<Map<String, Object>> listenForResult(){
    Completer completer = Completer();
    //listen for response from service worker
    BroadcastChannel oauthCallbackChannel = new BroadcastChannel('oauth_callback');
    oauthCallbackChannel.onMessage.listen((event) {
      print('Received broadcast event');
      print(event.data);
      completer.complete(event.data);
    });
    return completer.future;
  }
}