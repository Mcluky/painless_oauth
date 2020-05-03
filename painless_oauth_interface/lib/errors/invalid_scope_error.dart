import 'package:painless_oauth_interface/errors/generic_oauth_flow_error.dart';

///From https://tools.ietf.org/html/rfc6749#section-5.2
class InvalidScopeError extends GenericOAuthFlowError {
  static const String errorName = 'invalid_scope';

  static const String _defaultErrorDescription = '''The requested scope is invalid, unknown, malformed, or
               exceeds the scope granted by the resource owner.''';

  static const String _defaultErrorUriString = 'https://tools.ietf.org/html/rfc6749#section-5.2';

  /// Defaults [errorDescription] and [errorUri] to values provided by [rfc6749](https://tools.ietf.org/html/rfc6749#section-5.2)
  InvalidScopeError([String errorDescription, String errorUri])
      : super(errorName, errorDescription ?? _defaultErrorDescription, errorUri ?? _defaultErrorUriString);
}
