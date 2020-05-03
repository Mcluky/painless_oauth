import 'package:painless_oauth_interface/error/generic_oauth_flow_error.dart';

///From https://tools.ietf.org/html/rfc6749#section-5.2
class InvalidGrantError extends GenericOAuthFlowError {
  static const String _errorName = 'invalid_grant';

  static const String _defaultErrorDescription = '''The provided authorization grant (e.g., authorization
               code, resource owner credentials) or refresh token is
               invalid, expired, revoked, does not match the redirection
               URI used in the authorization request, or was issued to
               another client.''';

  static const String _defaultErrorUriString = 'https://tools.ietf.org/html/rfc6749#section-5.2';

  /// Defaults [errorDescription] and [errorUri] to values provided by [rfc6749](https://tools.ietf.org/html/rfc6749#section-5.2)
  InvalidGrantError([String errorDescription, String errorUri])
      : super(_errorName, errorDescription ?? _defaultErrorDescription, errorUri ?? _defaultErrorUriString);
}
