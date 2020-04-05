import 'package:flutter/cupertino.dart';
import 'package:painless_oauth/constants/grant_types.dart';
import 'package:painless_oauth/constants/reponse_types.dart';
import 'package:painless_oauth_interface/authorization_client.dart';

/// Use this OAuth client for implicit flow services that don't have yet an official
/// support for this library. It offers only a minimal abstraction over other official clients.
class BasicImplicitOAuthClient implements AuthorizationClient {
  final Uri authorizationUrl;
  final String responseType;
  final String clientId;
  final Uri redirectUri;
  final List<String> scopes;
  final String state;
  final Map<String, String> additionalRequestParameters;

  BasicImplicitOAuthClient(
      {@required this.authorizationUrl,
      @required this.clientId,
      @required this.redirectUri,
      this.responseType = ResponseType.implicitFlow,
      this.scopes,
      this.state,
      this.additionalRequestParameters});
}

/// Use this OAuth client for code flow services that don't have yet an official
/// support for this library. It offers only a minimal abstraction over other official clients.
class BasicCodeOAuthClient extends BasicImplicitOAuthClient {
  final Uri tokenUrl;
  final String clientSecret;
  final String grantType;

  BasicCodeOAuthClient(
      {@required this.tokenUrl, @required this.clientSecret, this.grantType = GrantType.authorizationCode});
}
