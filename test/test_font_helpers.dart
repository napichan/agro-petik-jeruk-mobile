import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// Font Inter tidak tersedia saat widget test (google_fonts mengunduhnya
/// saat runtime), sehingga test memakai font bawaan yang lebih lebar dan
/// memicu overflow RenderFlex di halaman yang layout-nya ketat.
///
/// Fungsi ini hanya mengabaikan pesan "A RenderFlex overflowed";
/// error lain tetap diteruskan ke handler bawaan flutter_test sehingga
/// test tetap gagal bila ada masalah nyata.
///
/// Harus dipanggil di dalam badan test (setelah flutter_test memasang
/// handler error-nya), mis. di awal helper pump.
void ignoreTestFontOverflow() {
  final previousOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
      return;
    }
    previousOnError?.call(details);
  };
  addTearDown(() => FlutterError.onError = previousOnError);
}
