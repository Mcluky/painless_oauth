import 'package:flutter_test/flutter_test.dart';

void assertUri(Uri actual, Uri other) {
  expect(actual.scheme, other.scheme, reason: "Expected scheme to be identical.");
  expect(actual.userInfo, other.userInfo, reason: "Expected userInfo to be identical.");
  expect(actual.host, other.host, reason: "Expected host to be identical.");
  expect(actual.port, other.port, reason: "Expected port to be identical.");
  expect(actual.path, other.path, reason: "Expected path to be identical.");
  expect(actual.queryParameters, other.queryParameters, reason: "Expected queryParameters to be identical.");
  expect(actual.fragment, other.fragment, reason: "Expected fragment to be identical.");
}
