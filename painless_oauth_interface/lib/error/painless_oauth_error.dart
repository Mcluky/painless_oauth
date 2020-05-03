abstract class PainlessOAuthError extends Error {
  /// Error in short in snake case (E.g "invalid_request").
  String get error;

  ///@Nullable. Human-readable text providing additional information for the error that occurred.
  String get errorDescription;

  ///@Nullable. A URI identifying a human-readable web page with information about the error.
  Uri get errorUri;
}
