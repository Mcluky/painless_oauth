class WebAuthorizationComponent {
  static const WebAuthorizationComponent iframe = WebAuthorizationComponent('iframe');
  static final WebAuthorizationComponent popUp = WebAuthorizationComponent('popUp');
  static final WebAuthorizationComponent tab = WebAuthorizationComponent('tab');

  final String componentName;

  const WebAuthorizationComponent(this.componentName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WebAuthorizationComponent &&
              runtimeType == other.runtimeType &&
              componentName?.toLowerCase() == other.componentName?.toLowerCase();

  @override
  int get hashCode => componentName.hashCode;
}