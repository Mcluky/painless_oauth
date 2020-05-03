import 'package:painless_oauth_interface/errors/generic_oauth_flow_error.dart';

///From https://tools.ietf.org/html/rfc6749#section-5.2
class InvalidClientError extends GenericOAuthFlowError {
  static const String errorName = 'invalid_client';

  static const String _defaultErrorDescription = '''Client authentication failed (e.g., unknown client, no
               client authentication included, or unsupported
               authentication method).  The authorization server MAY
               return an HTTP 401 (Unauthorized) status code to indicate
               which HTTP authentication schemes are supported.  If the
               client attempted to authenticate via the "Authorization"
               request header field, the authorization server MUST
               respond with an HTTP 401 (Unauthorized) status code and
               include the "WWW-Authenticate" response header field
               matching the authentication scheme used by the client.''';

  static const String _defaultErrorUriString = 'https://tools.ietf.org/html/rfc6749#section-5.2';

  /// Defaults [errorDescription] and [errorUri] to values provided by [rfc6749](https://tools.ietf.org/html/rfc6749#section-5.2)
  InvalidClientError([String errorDescription, String errorUri])
      : super(errorName, errorDescription ?? _defaultErrorDescription, errorUri ?? _defaultErrorUriString);
}
