import 'dart:html';

import 'package:painless_oauth_interface/authorization_client.dart';

class WindowTabManager {
  ///@Nullable if no window is currently active.
  WindowBase _activeAuthorizationWindow;

  /// Opens the authorization page in a new tab.
  void openInNewTab(AuthorizationClient authorizationClient) {
    closeActiveWindow();
    String authorizationUri = _getAuthorizationUri(authorizationClient);
    _activeAuthorizationWindow = window.open(authorizationUri, 'Authentication window');
  }

  /// Opens the authorization page in a popup.
  void openInPopup(AuthorizationClient authorizationClient) {
    closeActiveWindow();
    String windowFeatures = 'height=500,width=400,menubar=no,toolbar=no';
    String authorizationUri = _getAuthorizationUri(authorizationClient);
    _activeAuthorizationWindow = window.open(authorizationUri, 'Authentication window', windowFeatures);
  }

  /// Closes the active window. Does nothing when no window is open.
  void closeActiveWindow() {
    _activeAuthorizationWindow?.close();
    _activeAuthorizationWindow = null;
  }

  /// Get the authorization url with filled in parameters.
  String _getAuthorizationUri(AuthorizationClient authorizationClient) {
    Uri authorizationUri = authorizationClient.parametrizedAuthorizationUri;
    return authorizationUri.toString();
  }
}
