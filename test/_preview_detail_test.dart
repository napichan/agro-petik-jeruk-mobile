import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';
import 'package:flutter_agrowisatajeruk/features/activity/presentation/pages/detail_wisata_page.dart';

Future<void> _loadFonts() async {
  final loader = FontLoader('PlusJakartaSans');
  for (final weight in [
    'Regular',
    'Medium',
    'SemiBold',
    'Bold',
    'ExtraBold',
  ]) {
    final bytes = await rootBundle.load(
      'assets/fonts/PlusJakartaSans-$weight.ttf',
    );
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));
  }
  await loader.load();
}

void main() {
  testWidgets('render detail page', (tester) async {
    await tester.runAsync(() async {
      await _loadFonts();
    });

    tester.view.physicalSize = const Size(390 * 2, 844 * 2);
    tester.view.devicePixelRatio = 2;

    final key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: AppTextStyles.fontFamily),
        home: RepaintBoundary(key: key, child: const DetailWisataPage()),
      ),
    );
    await tester.pumpAndSettle();

    // Pastikan gambar hero selesai di-decode.
    await tester.runAsync(() => Future.delayed(const Duration(seconds: 1)));
    await tester.pumpAndSettle();

    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    await tester.runAsync(() async {
      final image = await boundary.toImage(pixelRatio: 2);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File('build/detail_preview.png');
      file.parent.createSync(recursive: true);
      file.writeAsBytesSync(data!.buffer.asUint8List());
    });
  });
}
