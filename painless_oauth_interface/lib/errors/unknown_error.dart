import 'package:painless_oauth_interface/errors/painless_oauth_error.dart';

class UnknownError extends PainlessOAuthError {
  static const String errorName = 'unknown_error';
  final dynamic cause;

  UnknownError(this.cause);

  @override
  String get error => errorName;

  @override
  String get errorDescription => cause.toString();

  @override
  Uri get errorUri => cause?.errorUri;
}