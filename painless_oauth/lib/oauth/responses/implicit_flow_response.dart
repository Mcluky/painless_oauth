/// A facade pattern to represent the implicit flow response defined in https://tools.ietf.org/html/rfc6749#section-4.2.2
class ImplicitFlowResponse {
  final Map<String, String> allResponseParameters;

  //todo add check if contains required parameters
  ImplicitFlowResponse(this.allResponseParameters);

  String get accessToken => allResponseParameters['access_token'];

  String get tokenType => allResponseParameters['token_type'];

  ///@Nullable. Only set when given a state parameter on request.
  String get state => allResponseParameters['state'];

  /// Defaults to 3600 seconds = 1 hour if not specified. (According to the examples in
  /// https://tools.ietf.org/html/rfc6749#section-4.2.2)
  Duration get expiresIn {
    String expiresInSecondsText = allResponseParameters['expires_in'];
    int expiresInSeconds = expiresInSecondsText != null ? int.parse(expiresInSecondsText) : 3600; //default to 1 hour
    Duration expiresIn = Duration(seconds: expiresInSeconds);
    return expiresIn;
  }

  /// Returns the scopes defined in the response. Defaults to empty list.
  List<String> get scopes {
    String encodedScopesText = allResponseParameters['scope'];
    if (encodedScopesText == null) return [];
    String decodedScopesText = Uri.decodeFull(encodedScopesText);
    List<String> scopes = decodedScopesText.split('');
    return scopes;
  }
}
