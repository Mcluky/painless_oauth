import 'package:flutter_test/flutter_test.dart';
import 'package:painless_oauth/clients/basic_oauth_client.dart';

import '../test_utils/uri_equality_helper.dart';

void main() {
  test("Expect correct authorization uri for web redirect uri", () {
    var authorizeUri = Uri.parse('https://my-oauth-server.com/authorize');
    var clientId = 'd6d7b2e8714b427ca3557ae71292100b';
    var redirectUri = Uri.parse('https://my-server.com/redirect');

    var basicImplicitFlowOAuthClient =
        new BasicImplicitFlowOAuthClient(authorizationUri: authorizeUri, clientId: clientId, redirectUri: redirectUri);

    var actualParametrizedAuthorizationUri = basicImplicitFlowOAuthClient.parametrizedAuthorizationUri;
    var expectParametrizedAuthorizationUri = Uri.parse(
        'https://my-oauth-server.com/authorize?client_id=d6d7b2e8714b427ca3557ae71292100b&redirect_uri=https%3A%2F%2Fmy-server.com%2Fredirect&response_type=token');
    assertUri(actualParametrizedAuthorizationUri, expectParametrizedAuthorizationUri);
  });

  test("Expect correct authorization uri for mobile redirect uri", () {
    var authorizeUri = Uri.parse('https://my-oauth-server.com/authorize');
    var clientId = 'd6d7b2e8714b427ca3557ae71292100b';
    var redirectUri = Uri.parse('painlessoauth://redirect');

    var basicImplicitFlowOAuthClient =
        new BasicImplicitFlowOAuthClient(authorizationUri: authorizeUri, clientId: clientId, redirectUri: redirectUri);

    var actualParametrizedAuthorizationUri = basicImplicitFlowOAuthClient.parametrizedAuthorizationUri;
    var expectParametrizedAuthorizationUri = Uri.parse(
        'https://my-oauth-server.com/authorize?client_id=d6d7b2e8714b427ca3557ae71292100b&response_type=token&redirect_uri=painlessoauth%3A%2F%2Fredirect');
    assertUri(actualParametrizedAuthorizationUri, expectParametrizedAuthorizationUri);
  });

  test("Expect all parameter encoded in uri", () {
    var authorizeUri = Uri.parse('https://my-oauth-server.com/authorize');
    var clientId = 'd6d7b2e8714b427ca3557ae71292100b';
    var redirectUri = Uri.parse('painlessoauth://redirect');
    var responseType = 'someweirdtoken';
    var state = 'some_random_state69';
    var scopes = ['scope one', 'scope two'];
    var additionalRequestParameter = {'additional-key': 'some value', 'another key': 'some other value'};

    var basicImplicitFlowOAuthClient = new BasicImplicitFlowOAuthClient(
        authorizationUri: authorizeUri,
        clientId: clientId,
        redirectUri: redirectUri,
        responseType: responseType,
        state: state,
        scopes: scopes,
        additionalRequestParameters: additionalRequestParameter);

    var actualParametrizedAuthorizationUri = basicImplicitFlowOAuthClient.parametrizedAuthorizationUri;
    var expectParametrizedAuthorizationUri = Uri.parse(
        'https://my-oauth-server.com/authorize?client_id=d6d7b2e8714b427ca3557ae71292100b&response_type=someweirdtoken'
        '&redirect_uri=painlessoauth%3A%2F%2Fredirect&scope=scope+one+scope+two&state=some_random_state69'
        '&additional-key=some+value&another+key=some+other+value');
    assertUri(actualParametrizedAuthorizationUri, expectParametrizedAuthorizationUri);
  });
}
