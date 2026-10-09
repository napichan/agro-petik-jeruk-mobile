import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_agrowisatajeruk/pages/beranda_page.dart';
import 'package:flutter_agrowisatajeruk/pages/citrus_scan_page.dart';
import 'package:flutter_agrowisatajeruk/pages/pesan_tiket_page.dart';
import 'package:flutter_agrowisatajeruk/pages/profile_page.dart';
import 'package:flutter_agrowisatajeruk/pages/riwayat_page.dart';
import 'package:flutter_agrowisatajeruk/pages/tiket_saya_page.dart';

import 'test_font_helpers.dart';

/// Merekam setiap rute yang di-push navigator untuk memastikan tombol nav
/// benar-benar menuju rute yang dituju.
class _PushRecorder extends NavigatorObserver {
  final List<String?> pushed = <String?>[];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed.add(route.settings.name);
  }
}

/// Helper: bungkus halaman dengan MaterialApp + rute bernama yang sama
/// seperti terdaftar di main.dart.
Widget _app(Widget home, _PushRecorder recorder) {
  return MaterialApp(
    home: home,
    navigatorObservers: [recorder],
    routes: {
      '/beranda': (_) => const BerandaPage(),
      '/pesan-tiket': (_) => const PesanTiketPage(),
      '/riwayat': (_) => const RiwayatPage(),
      '/profile': (_) => const ProfilePage(),
      '/citrus-scan': (_) => const CitrusScanPage(),
    },
  );
}

Future<void> _pumpPage(WidgetTester tester, Widget home) async {
  ignoreTestFontOverflow();
  await tester.pumpWidget(_app(home, _recorder));
  await tester.pump(const Duration(milliseconds: 100));
}

late _PushRecorder _recorder;

/// Tap tombol nav lalu pastikan rute tujuan ter-push dan halamannya tampil.
Future<void> _expectNav(
  WidgetTester tester, {
  required String navKey,
  required String expectedRoute,
  required Type expectedPage,
}) async {
  final pushedBefore = _recorder.pushed.length;

  await tester.tap(find.byKey(ValueKey(navKey)));
  // Cukup pump beberapa kali agar animasi transisi selesai; tanpa
  // pumpAndSettle karena sebagian halaman punya animasi looping.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));

  expect(
    _recorder.pushed.sublist(pushedBefore),
    contains(expectedRoute),
    reason: 'Tombol $navKey harus mendorong rute $expectedRoute',
  );
  expect(find.byType(expectedPage), findsWidgets);
}

void main() {
  setUp(() {
    _recorder = _PushRecorder();

    // Hindari percobaan unduh font Google secara runtime di dalam test.
    GoogleFonts.config.allowRuntimeFetching = false;

  });

  final hosts = <String, Widget Function()>{
    'TiketSayaPage': () => const TiketPage(),
    'RiwayatPage': () => const RiwayatPage(),
    'ProfilePage': () => const ProfilePage(),
  };

  final targets = <(String, String, Type)>[
    ('nav/beranda', '/beranda', BerandaPage),
    ('nav/pesan-tiket', '/pesan-tiket', PesanTiketPage),
    ('nav/citrus-scan', '/citrus-scan', CitrusScanPage),
    ('nav/riwayat', '/riwayat', RiwayatPage),
    ('nav/profile', '/profile', ProfilePage),
  ];

  for (final host in hosts.entries) {
    group('Bottom nav di ${host.key}', () {
      for (final (navKey, route, page) in targets) {
        testWidgets('menuju $route', (tester) async {
          await _pumpPage(tester, host.value());
          await _expectNav(
            tester,
            navKey: navKey,
            expectedRoute: route,
            expectedPage: page,
          );
        });
      }
    });
  }
}
