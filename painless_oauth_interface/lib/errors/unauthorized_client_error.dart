import 'package:painless_oauth_interface/errors/generic_oauth_flow_error.dart';

///From https://tools.ietf.org/html/rfc6749#section-5.2
class UnauthorizedClientError extends GenericOAuthFlowError {
  static const String errorName = 'unauthorized_client';

  static const String _defaultErrorDescription = '''The authenticated client is not authorized to use this
               authorization grant type.''';

  static const String _defaultErrorUriString = 'https://tools.ietf.org/html/rfc6749#section-5.2';

  /// Defaults [errorDescription] and [errorUri] to values provided by [rfc6749](https://tools.ietf.org/html/rfc6749#section-5.2)
  UnauthorizedClientError([String errorDescription, Uri errorUri])
      : super(errorName, errorDescription ?? _defaultErrorDescription, errorUri ?? Uri.parse(_defaultErrorUriString));
}
