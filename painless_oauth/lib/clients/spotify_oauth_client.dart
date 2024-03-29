import 'package:flutter/cupertino.dart';
import 'package:painless_oauth/constants/grant_types.dart';
import 'package:painless_oauth/constants/reponse_types.dart';

import 'basic_oauth_client.dart';

final Uri _spotifyAuthorizationUri = Uri.parse('https://accounts.spotify.com/authorize');
final Uri _spotifyTokenUri = Uri.parse('https://accounts.spotify.com/api/token');

class SpotifyImplicitFlowOAuthClient extends BasicImplicitFlowOAuthClient {
  SpotifyImplicitFlowOAuthClient(
      {@required Uri redirectUri,
      @required String clientId,
      List<String> scopes,
      String state,
      bool showDialog = false})
      : super(
            authorizationUri: _spotifyAuthorizationUri,
            clientId: clientId,
            redirectUri: redirectUri,
            responseType: ResponseType.implicitFlow,
            scopes: scopes,
            state: state,
            additionalRequestParameters: Map()) {
    this.additionalRequestParameters.putIfAbsent('show_dialog', () => showDialog.toString());
  }
}

class SpotifyCodeFlowOAuthClient extends BasicCodeFlowOAuthClient {
  SpotifyCodeFlowOAuthClient(
      {@required Uri redirectUri,
      @required String clientId,
      @required String clientSecret,
      List<String> scopes,
      String state,
      bool showDialog = false})
      : super(
            authorizationUri: _spotifyAuthorizationUri,
            tokenUri: _spotifyTokenUri,
            clientId: clientId,
            clientSecret: clientSecret,
            redirectUri: redirectUri,
            responseType: ResponseType.codeFlow,
            grantType: GrantType.authorizationCode,
            scopes: scopes,
            state: state,
            additionalRequestParameters: Map()) {
    this.additionalRequestParameters.putIfAbsent('show_dialog', () => showDialog.toString());
  }
}
