import 'dart:async';
import 'dart:io';

import 'package:flutter_project/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) =>
      Future.value(MockHttpClientRequest());
}

class MockHttpClientRequest extends Mock implements HttpClientRequest {
  @override
  final HttpHeaders headers = MockHttpHeaders();

  @override
  Future<HttpClientResponse> close() => Future.value(MockHttpClientResponse());
}

class MockHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  int get statusCode => HttpStatus.ok;

  @override
  int get contentLength => kTransparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream.value(kTransparentImage).listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }
}

class MockHttpHeaders extends Mock implements HttpHeaders {}

const List<int> kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
];

void main() {
  testWidgets('App creates a MacosWindow and MacosScaffold', (WidgetTester tester) async {
    await HttpOverrides.runZoned(
      () async {
        await tester.runAsync(() async {
          await tester.pumpWidget(const MyApp());
        });
      },
      createHttpClient: (_) => MockHttpClient(),
    );

    // Verify that our app has a MacosWindow.
    expect(find.byType(MacosWindow), findsOneWidget);

    // Verify that our app has a MacosScaffold.
    expect(find.byType(MacosScaffold), findsOneWidget);
  });
}
