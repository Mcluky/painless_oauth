import 'package:painless_oauth_interface/error/generic_oauth_flow_error.dart';

///From https://tools.ietf.org/html/rfc6749#section-5.2
class InvalidRequestError extends GenericOAuthFlowError {
  static const String _errorName = 'invalid_request';

  static const String _defaultErrorDescription = '''The request is missing a required parameter, includes an
               unsupported parameter value (other than grant type),
               repeats a parameter, includes multiple credentials,
               utilizes more than one mechanism for authenticating the
               client, or is otherwise malformed.''';

  static const String _defaultErrorUriString = 'https://tools.ietf.org/html/rfc6749#section-5.2';

  /// Defaults [errorDescription] and [errorUri] to values provided by [rfc6749](https://tools.ietf.org/html/rfc6749#section-5.2)
  InvalidRequestError([String errorDescription, String errorUri])
      : super(_errorName, errorDescription ?? _defaultErrorDescription, errorUri ?? _defaultErrorUriString);
}
