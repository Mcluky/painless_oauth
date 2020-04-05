abstract class AuthorizationClient {
  /// Url of authorization page
  /// E.g: (Spotify) https://accounts.spotify.com/authorize
  /// (Azure)
  Uri get authorizationUri;
  String get responseType;
  String get clientId;
  Uri get redirectUri;
  /// @Nullable. Optional, describes the required access points or features
  List<String> get scopes;
  /// @Nullable. Optional but recommended
  String get state;
  /// @Nullable. Optional, additional request parameters
  Map<String, String> get additionalRequestParameters;

  AuthorizationClient._();
}