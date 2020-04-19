abstract class PainlessOAuthError {
  /// Error in short in snake case (E.g "invalid_request").
  String get error;

  ///@Nullable. Human-readable text providing additional information for the error that occurred.
  String get errorDescription;

  PainlessOAuthError._();
}
