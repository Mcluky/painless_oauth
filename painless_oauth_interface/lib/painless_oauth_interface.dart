import 'package:flutter/widgets.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of painless_oauth must implement.
///
/// If you want to add your own implementation for a specific platform,
/// use this package as a dependency and extend this class
abstract class PainlessOAuthPlatform extends PlatformInterface {
  //this token ensures that the class is extended and not implemented
  static final Object _token = Object();
  static PainlessOAuthPlatform _instance;

  static set instance(PainlessOAuthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  static PainlessOAuthPlatform get instance => _instance;

  PainlessOAuthPlatform(): super(token: _token);

  /// Ensures that an authorization page is shown. It is not guaranteed that this
  /// widget is actually the authorization page widget itself. E.g the actual authorization can happen
  /// in a popup window, in this case this widget should display a loading bar or something similar
  /// meanwhile the actual action happens on the popup.
  ///
  /// [platformSpecificOptions] is meant for individual options on a platform that is only available there.
  /// This is useful for platform specific options.
  /// Always start with the platform itself in the key.
  /// E.g:
  /// [platformSpecificOptions].putIfAbsent('ios.safariUseJavaScript', () => true);
  /// [platformSpecificOptions].putIfAbsent('web.useComponent', () => 'iframe');
  Widget authorizationPage({@required AuthorizationClient authorizationClient,
    Map<String, Object> platformSpecificOptions = const {}}) {
    throw UnimplementedError('authorizationPage() has not been implemented.');
  }

  /// This method returns a map containing the response from the authorization service. Throws an Error when the
  /// authorization failed.
  Future<Map<String, String>> listenForResult(AuthorizationClient authorizationClient) async {
    throw UnimplementedError('listenForResult() has not been implemented.');
  }
}
