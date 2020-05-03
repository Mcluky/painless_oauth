import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:painless_oauth/oauth/responses/error_response.dart';
import 'package:painless_oauth/src/oauth/error_parser.dart';
import 'package:painless_oauth_interface/errors/invalid_client_error.dart';
import 'package:painless_oauth_interface/errors/invalid_grant_error.dart';
import 'package:painless_oauth_interface/errors/invalid_request_error.dart';
import 'package:painless_oauth_interface/errors/invalid_scope_error.dart';
import 'package:painless_oauth_interface/errors/unauthorized_client_error.dart';
import 'package:painless_oauth_interface/errors/unsupported_grant_type_error.dart';

class MockErrorResponse extends Mock implements ErrorResponse {}

void main() {
  ErrorParser errorParser = ErrorParser();

  test("Expect error object to contain description", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('invalid_client');
    when(errorResponse.errorDescription).thenReturn('artifical error description.');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    var actualErrorDescription = actualError.errorDescription;
    var expectedErrorDescription = 'artifical error description.';
    expect(actualErrorDescription, expectedErrorDescription);
  });

  test("Expect error object to contain uri", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('invalid_client');
    when(errorResponse.errorUri).thenReturn(Uri.parse('http://invalid_client.errors.net'));

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    var actualErrorUri = actualError.errorUri;
    var expectedErrorUri = Uri.parse('http://invalid_client.errors.net');
    expect(actualErrorUri, expectedErrorUri);
  });

  test("Expect some default value for error description and uri for a known error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('invalid_client');
    when(errorResponse.errorDescription).thenReturn(null);
    when(errorResponse.errorUri).thenReturn(null);

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    var actualErrorDescription = actualError.errorDescription;
    var actualErrorUri = actualError.errorUri;
    expect(actualErrorUri, isNotNull);
    expect(actualErrorDescription, isNotNull);
  });

  test("Expect invalid client error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('invalid_client');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    expect(actualError, isA<InvalidClientError>());
  });

  test("Expect invalid grant error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('invalid_grant');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    expect(actualError, isA<InvalidGrantError>());
  });

  test("Expect invalid request error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('invalid_request');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    expect(actualError, isA<InvalidRequestError>());
  });

  test("Expect invalid scope error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('invalid_scope');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    expect(actualError, isA<InvalidScopeError>());
  });

  test("Expect unauthorized client error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('unauthorized_client');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    expect(actualError, isA<UnauthorizedClientError>());
  });

  test("Expect unsupported grant type error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('unsupported_grant_type');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    expect(actualError, isA<UnsupportedGrantTypeError>());
  });

  test("Expect repsonse as unkown error", () {
    var errorResponse = MockErrorResponse();
    when(errorResponse.error).thenReturn('unsupported_grant_type');

    var actualError = errorParser.tryParseToSpecificError(errorResponse);

    expect(actualError, isA<UnsupportedGrantTypeError>());
  });
}
