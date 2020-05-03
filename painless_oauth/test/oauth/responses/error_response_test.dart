import 'package:flutter_test/flutter_test.dart';
import 'package:painless_oauth/oauth/responses/error_response.dart';

import '../../test_utils/uri_equality_helper.dart';

var mockJsonResponse = {
  'error': 'invalid_request',
  'error_description': '''The request is missing a required parameter, includes an
               unsupported parameter value (other than grant type),
               repeats a parameter, includes multiple credentials,
               utilizes more than one mechanism for authenticating the
               client, or is otherwise malformed.''',
  'error_uri': 'https://tools.ietf.org/html/rfc6749#section-5.2'
};

void main() {
  test('Expect json response to be an error', () {
    var isErrorResponse = ErrorResponse.isErrorResponse(mockJsonResponse);

    assert(isErrorResponse, 'Expect json response to be an error');
  });

  test('Expect error name to be expected name', () {
    var errorResponse = ErrorResponse(mockJsonResponse);

    var actualErrorName = errorResponse.error;
    var expectedErrorName = mockJsonResponse['error'];

    expect(actualErrorName, expectedErrorName);
  });

  test('Expect error description to be expected description', () {
    var errorResponse = ErrorResponse(mockJsonResponse);

    var actualDescription = errorResponse.errorDescription;
    var expectedDescription = mockJsonResponse['error_description'];

    expect(actualDescription, expectedDescription);
  });

  test('Expect error uri to be expected uri', () {
    var errorResponse = ErrorResponse(mockJsonResponse);

    var actualUri = errorResponse.errorUri;
    var expectedUri = Uri.parse(mockJsonResponse['error_uri']);

    assertUri(actualUri, expectedUri);
  });
}
