import 'package:flutter/cupertino.dart';
import 'package:painless_oauth/constants/grant_types.dart';
import 'package:painless_oauth/constants/reponse_types.dart';
import 'package:painless_oauth_interface/authorization_client.dart';

/// Use this OAuth client for implicit flow services that don't have yet an official
/// support for this library. It offers only a minimal abstraction over other official clients.
class BasicImplicitFlowOAuthClient implements AuthorizationClient {
  final Uri authorizationUri;
  final String responseType;
  final String clientId;
  final Uri redirectUri;
  final List<String> scopes;
  final String state;
  final Map<String, String> additionalRequestParameters;

  BasicImplicitFlowOAuthClient(
      {@required this.authorizationUri,
      @required this.clientId,
      @required this.redirectUri,
      this.responseType = ResponseType.implicitFlow,
      this.scopes,
      this.state,
      this.additionalRequestParameters});
}

/// Use this OAuth client for code flow services that don't have yet an official
/// support for this library. It offers only a minimal abstraction over other official clients.
class BasicCodeFlowOAuthClient extends BasicImplicitFlowOAuthClient {
  final Uri tokenUri;
  final String clientSecret;
  BasicCodeFlowOAuthClient(
      {@required Uri authorizationUri,
      @required this.tokenUri,
      @required Uri redirectUri,
      @required String clientId,
      @required this.clientSecret,
      String responseType = ResponseType.codeFlow,
      this.grantType = GrantType.authorizationCode,
      List<String> scopes,
      String state,
      Map<String, String> additionalRequestParameters})
      : super(
            authorizationUri: authorizationUri,
            clientId: clientId,
            redirectUri: redirectUri,
            responseType: responseType,
            scopes: scopes,
            state: state,
            additionalRequestParameters: additionalRequestParameters);

  final String grantType;
}
