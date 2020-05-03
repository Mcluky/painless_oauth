import 'dart:async';

import 'package:flutter/material.dart';
import 'package:painless_oauth/oauth/responses/error_response.dart';
import 'package:painless_oauth/oauth/responses/implicit_flow_response.dart';
import 'package:painless_oauth/src/widget/implicit_flow_hidden_refresh_page.dart';
import 'package:painless_oauth/src/widget/login_page.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/errors/painless_oauth_error.dart';
import 'package:painless_oauth_interface/errors/unknown_error.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';

class ImplicitAuthenticator {
  final AuthorizationClient authorizationClient;

  ImplicitAuthenticator(this.authorizationClient)
      : assert(authorizationClient != null, "The AuthorizationClient must not be null.");

  ///Opens the authorization login screen on which the user should log in.
  Future<ImplicitFlowResponse> login(BuildContext context, [Map<String, Object> platformSpecificOptions]) {
    platformSpecificOptions ??= const {}; // default to empty map

    var futureOAuthResponse = PainlessOAuthPlatform.instance.listenForResult(authorizationClient);

    showDialog(
        context: context,
        child: LoginPage(authorizationClient: authorizationClient, platformSpecificOptions: platformSpecificOptions));

    return _handleImplicitFlowResponse(futureOAuthResponse);
  }

  /// Silently refreshes a implicit token
  Future<ImplicitFlowResponse> silentRefresh(BuildContext context, [Map<String, Object> platformSpecificOptions]) {
    platformSpecificOptions ??= const {}; // default to empty map

    var futureOAuthResponse = PainlessOAuthPlatform.instance.listenForResult(authorizationClient);

    OverlayEntry hiddenOAuthPage = OverlayEntry(
        maintainState: true,
        builder: (context) => ImplicitFlowHiddenRefreshPage(
            authorizationClient: authorizationClient, platformSpecificOptions: platformSpecificOptions));
    Overlay.of(context).insert(hiddenOAuthPage);

    return _handleImplicitFlowResponse(futureOAuthResponse);
  }

  Future<ImplicitFlowResponse> _handleImplicitFlowResponse(Future<Map<String, String>> futureOAuthResponse) {
    return futureOAuthResponse.then((responseData) {
      return _handleImplicitFlowResponseData(responseData);
    }).catchError((error) {
      if (error is PainlessOAuthError) {
        throw error; // Forward known/controlled errors
      }
      throw UnknownError(error); // wrap error in a controlled error
    });
  }

  ImplicitFlowResponse _handleImplicitFlowResponseData(Map<String, String> responseData) {
    bool isError = ErrorResponse.isErrorResponse(responseData);
    if (isError) {
      ErrorResponse errorResponse = ErrorResponse(responseData);
      throw errorResponse;
    }
    return ImplicitFlowResponse(responseData);
  }
}
