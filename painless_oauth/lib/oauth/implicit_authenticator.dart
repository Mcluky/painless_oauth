import 'dart:async';

import 'package:flutter/material.dart';
import 'package:painless_oauth/oauth/responses/error_response.dart';
import 'package:painless_oauth/oauth/responses/implicit_flow_response.dart';
import 'package:painless_oauth/src/widget/login_page.dart';
import 'package:painless_oauth_interface/authorization_client.dart';
import 'package:painless_oauth_interface/painless_oauth_interface.dart';

class ImplicitAuthenticator {
  Future<ImplicitFlowResponse> login(BuildContext context, AuthorizationClient authorizationClient,
      [Map<String, Object> platformSpecificOptions = const {}]) {
    Completer<ImplicitFlowResponse> completer = Completer();
    PainlessOAuthPlatform.instance.listenForResult(authorizationClient).then((resultParameters) {
      bool isError = ErrorResponse.isErrorResponse(resultParameters);
      if (isError) {
        ErrorResponse errorResponse = ErrorResponse(resultParameters);
        completer.completeError(errorResponse);
      }
      ImplicitFlowResponse response = ImplicitFlowResponse(resultParameters);
      completer.complete(response);
    });
    showDialog(
        context: context,
        child: LoginPage(authorizationClient: authorizationClient, platformSpecificOptions: platformSpecificOptions));
    return completer.future;
  }
}
