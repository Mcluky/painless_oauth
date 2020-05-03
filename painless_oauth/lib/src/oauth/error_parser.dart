import 'package:painless_oauth/oauth/responses/error_response.dart';
import 'package:painless_oauth_interface/errors/invalid_client_error.dart';
import 'package:painless_oauth_interface/errors/invalid_grant_error.dart';
import 'package:painless_oauth_interface/errors/invalid_request_error.dart';
import 'package:painless_oauth_interface/errors/invalid_scope_error.dart';
import 'package:painless_oauth_interface/errors/painless_oauth_error.dart';
import 'package:painless_oauth_interface/errors/unauthorized_client_error.dart';
import 'package:painless_oauth_interface/errors/unsupported_grant_type_error.dart';

class ErrorParser {
  /// This method tries to parse an error response to a specific error implementation like defined in the
  /// (rfc6749)[https://tools.ietf.org/html/rfc6749#section-5.2].
  /// In case the method cannot find a matching error, it will return the error response itself.
  PainlessOAuthError tryParseToSpecificError(ErrorResponse errorResponse) {
    String errorName = errorResponse.error;
    String errorDescription = errorResponse.errorDescription;
    Uri errorUri = errorResponse.errorUri;
    switch (errorName) {
      case InvalidClientError.errorName:
        return InvalidClientError(errorDescription, errorUri);
      case InvalidGrantError.errorName:
        return InvalidGrantError(errorDescription, errorUri);
      case InvalidRequestError.errorName:
        return InvalidRequestError(errorDescription, errorUri);
      case InvalidScopeError.errorName:
        return InvalidScopeError(errorDescription, errorUri);
      case UnauthorizedClientError.errorName:
        return UnauthorizedClientError(errorDescription, errorUri);
      case UnsupportedGrantTypeError.errorName:
        return UnsupportedGrantTypeError(errorDescription, errorUri);
      default:
        return errorResponse;
    }
  }
}
