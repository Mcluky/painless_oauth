import 'package:flutter_test/flutter_test.dart';
import 'package:painless_oauth/constants/reponse_types.dart';
import 'package:painless_oauth/oauth/responses/error_response.dart';
import 'package:painless_oauth/oauth/responses/implicit_flow_response.dart';

import '../../test_utils/uri_equality_helper.dart';

var expiresIn = Duration(seconds: 200);

var mockJsonResponse = {
  'access_token': '1241512354235adddccc2314',
  'token_type': ResponseType.implicitFlow,
  'state': 'ajhfqiahfwiuqahfwa213214ejkwqdhkjqwehk',
  'expires_in': expiresIn.inSeconds.toString(),
  'scope': 'user_access profile_picture',
};

void main() {
  test('Expect reponse token to be expected token', () {
    var implicitFlowResponse = ImplicitFlowResponse(mockJsonResponse);

    var actualToken = implicitFlowResponse.accessToken;
    var expectedToken = mockJsonResponse['access_token'];

    expect(actualToken, expectedToken);
  });

  test('Expect reponse token typ to be expected token typ', () {
    var implicitFlowResponse = ImplicitFlowResponse(mockJsonResponse);

    var actualTokenTyp = implicitFlowResponse.tokenType;
    var expectedTokenTyp = mockJsonResponse['token_type'];

    expect(actualTokenTyp, expectedTokenTyp);
  });

  test('Expect reponse state to be expected state', () {
    var implicitFlowResponse = ImplicitFlowResponse(mockJsonResponse);

    var actualState = implicitFlowResponse.state;
    var expectedState = mockJsonResponse['state'];

    expect(actualState, expectedState);
  });

  test('Expect expire duration to be expected expire duration', () {
    var implicitFlowResponse = ImplicitFlowResponse(mockJsonResponse);

    var actualExpireDuration = implicitFlowResponse.expiresIn;
    var expectedExpireDuration = expiresIn;

    expect(actualExpireDuration, expectedExpireDuration);
  });

  test('Expect scopes to be expected scopes', () {
    var implicitFlowResponse = ImplicitFlowResponse(mockJsonResponse);

    var actualScopes = implicitFlowResponse.scopes;
    var expectedScopes = ['user_access', 'profile_picture'];

    expect(actualScopes, containsAll(expectedScopes));
  });

  test('Expect default expire duration of 1 hour', () {
    var noExpiresInJsonResponse = {
      'access_token': '1241512354235adddccc2314',
      'token_type': ResponseType.implicitFlow,
    };
    var implicitFlowResponse = ImplicitFlowResponse(noExpiresInJsonResponse);

    var actualExpireDuration = implicitFlowResponse.expiresIn;
    var expectedExpireDuration = Duration(hours: 1);

    expect(actualExpireDuration, expectedExpireDuration);
  });

  test('Expect default empty list for scopes', () {
    var noExpiresInJsonResponse = {
      'access_token': '1241512354235adddccc2314',
      'token_type': ResponseType.implicitFlow,
    };
    var implicitFlowResponse = ImplicitFlowResponse(noExpiresInJsonResponse);

    var actualScopes = implicitFlowResponse.scopes;
    var expectedScopes = [];

    expect(actualScopes, expectedScopes);
  });
}
