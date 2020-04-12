/// A representation of the error reponse defined in https://tools.ietf.org/html/rfc6749#section-5.2
class ErrorResponse {
  final Map<String, String> allResponseParameters;

  //todo add check if contains required parameters
  ErrorResponse(this.allResponseParameters);

  /// Checks if the given response parameters are of the type error
  static bool isErrorResponse(Map<String, String> responseParameters) {
    bool isErrorResponse = responseParameters.containsKey('error');
    return isErrorResponse;
  }

  /// All error types are defined here https://tools.ietf.org/html/rfc6749#section-5.2
  String get error => allResponseParameters['error'];

  ///@Nullable. Human-readable text providing additional information for the error that occurred.
  String get errorDescription => allResponseParameters['error_description'];

  ///@Nullable. A URI identifying a human-readable web page with information about the error.
  Uri get errorUri {
    String errorUriText = allResponseParameters['error_uri'];
    Uri errorUri = errorUriText != null ? Uri.parse(errorUriText) : null;
    return errorUri;
  }
}
