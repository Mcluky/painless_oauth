import 'package:painless_oauth_interface/error/generic_oauth_flow_error.dart';

///From https://tools.ietf.org/html/rfc6749#section-5.2
class UnsupportedGrantTypeError extends GenericOAuthFlowError {
  static const String _errorName = 'unsupported_grant_type';

  static const String _defaultErrorDescription = '''The authorization grant type is not supported by the
               authorization server.''';

  static const String _defaultErrorUriString = 'https://tools.ietf.org/html/rfc6749#section-5.2';

  /// Defaults [errorDescription] and [errorUri] to values provided by [rfc6749](https://tools.ietf.org/html/rfc6749#section-5.2)
  UnsupportedGrantTypeError([String errorDescription, String errorUri])
      : super(_errorName, errorDescription ?? _defaultErrorDescription, errorUri ?? _defaultErrorUriString);
}
