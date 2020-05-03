import 'package:painless_oauth_interface/errors/painless_oauth_error.dart';

abstract class GenericOAuthFlowError extends PainlessOAuthError {
  final String error;

  /// @Nullable
  final String errorDescription;

  /// @Nullable
  final Uri errorUri;

  GenericOAuthFlowError(this.error, [this.errorDescription, String errorUriString])
      : errorUri = errorUriString != null ? Uri.parse(errorUriString) : null;
}
