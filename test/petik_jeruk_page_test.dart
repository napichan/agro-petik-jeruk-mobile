import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_agrowisatajeruk/pages/aktivitas_page.dart';
import 'package:flutter_agrowisatajeruk/pages/petik_jeruk_page.dart';
import 'package:flutter_agrowisatajeruk/pages/profile_page.dart';

import 'test_font_helpers.dart';

/// Merekam rute yang di-push navigator.
class _PushRecorder extends NavigatorObserver {
  final List<String?> pushed = <String?>[];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed.add(route.settings.name);
  }
}

late _PushRecorder _recorder;

Future<void> _pumpPetik(WidgetTester tester) async {
  ignoreTestFontOverflow();
  _recorder = _PushRecorder();
  await tester.pumpWidget(
    MaterialApp(
      home: const PetikJerukPage(),
      navigatorObservers: [_recorder],
      routes: {
        '/aktivitas': (_) => const AktivitasPage(),
        '/profile': (_) => const ProfilePage(),
      },
    ),
  );
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('menampilkan konten sesuai desain UI', (tester) async {
    await _pumpPetik(tester);

    // Judul, alamat, statistik.
    expect(find.text('Petik Jeruk Langsung'), findsOneWidget);
    expect(find.textContaining('Jl. Watu Gede'), findsOneWidget);
    expect(find.text('2 - 3 Jam'), findsOneWidget);
    expect(find.text('Rp 20.000'), findsOneWidget);
    expect(find.text('4.7 (1.2k)'), findsOneWidget);

    // Section utama.
    expect(find.text('Aktivitas'), findsOneWidget);
    expect(find.text('Fasilitas'), findsOneWidget);
    expect(find.text('Titik Kumpul'), findsOneWidget);
    expect(find.text('Ulasan Pengunjung'), findsOneWidget);

    // Isi daftar aktivitas, fasilitas, titik kumpul & ulasan.
    expect(
      find.text('Petik & makan jeruk segar sepuasnya di kebun'),
      findsOneWidget,
    );
    expect(find.text('Peminjaman keranjang rotan & gunting petik'),
        findsOneWidget);
    expect(find.text('Akses jelajah kebun lereng 850 mdpl'), findsOneWidget);
    expect(find.text('Didampingi pemandu petani lokal'), findsOneWidget);
    for (final f in ['Parkir', 'Toilet', 'Glubuk', 'Toko']) {
      expect(find.text(f), findsOneWidget);
    }
    expect(find.text('Pintu Masuk Utama (Blok A)'), findsOneWidget);
    expect(find.text('Rina Kusumawardani'), findsOneWidget);
    expect(find.text('Terverifikasi'), findsOneWidget);
    expect(find.text('Buka Maps'), findsOneWidget);
  });

  testWidgets('gambar hero memakai asset Kebun Jeruk Solorejo', (tester) async {
    await _pumpPetik(tester);

    final images = tester.widgetList<Image>(find.byType(Image));
    expect(images, isNotEmpty);

    final hero = images.first.image;
    expect(hero, isA<AssetImage>());
    expect(
      (hero as AssetImage).assetName,
      'assets/images/Kebun Jeruk Solorejo.png',
    );
  });

  testWidgets('tombol kembali navigasi ke halaman Aktivitas', (tester) async {
    await _pumpPetik(tester);

    await tester.tap(find.byKey(const ValueKey('petik-kembali')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(_recorder.pushed, contains('/aktivitas'));
    expect(find.byType(AktivitasPage), findsOneWidget);
  });

  testWidgets('tombol profil navigasi ke halaman Profile', (tester) async {
    await _pumpPetik(tester);

    await tester.tap(find.byKey(const ValueKey('petik-profil')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(_recorder.pushed, contains('/profile'));
    expect(find.byType(ProfilePage), findsOneWidget);
  });
}
