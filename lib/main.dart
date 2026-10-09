import 'package:flutter/material.dart';

// Import seluruh halaman aplikasi
import 'pages/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/verifikasi_page.dart';
import 'pages/beranda_page.dart';
import 'pages/pesan_tiket_page.dart';
import 'pages/detail_tiket_page.dart';
import 'pages/pembayaran_page.dart';
import 'pages/pembayaran_berhasil_page.dart';
import 'pages/tiket_saya_page.dart';
import 'pages/riwayat_page.dart';
import 'pages/notifikasi_page.dart';
import 'pages/citrus_scan_page.dart';
import 'pages/profile_page.dart';
import 'pages/aktivitas_page.dart';
import 'pages/petik_jeruk_page.dart';
import 'pages/edukasi_page.dart';
import 'pages/wawancara_page.dart';
import 'pages/penelitian_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agro Petik Jeruk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF97316), // Warna dasar oranye
        ),
        useMaterial3: true,
      ),
      // Set halaman pertama ke SplashScreen
      home: const SplashScreen(),
      
      // Mendaftarkan rute bernama untuk navigasi praktis
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/verifikasi': (context) => const VerifikasiPage(),
        '/beranda': (context) => const BerandaPage(),
        '/pesan-tiket': (context) => const PesanTiketPage(),
        '/detail-tiket': (context) => const DetailTiketPage(),
        '/pembayaran': (context) => const PembayaranPage(),
        '/pembayaran-berhasil': (context) => const PembayaranBerhasilPage(),
        '/tiket': (context) => const TiketPage(),
        '/riwayat': (context) => const RiwayatPage(),
        '/notifikasi': (context) => const NotifikasiPage(),
        '/citrus-scan': (context) => const CitrusScanPage(),
        '/profile': (context) => const ProfilePage(),
        '/aktivitas': (context) => const AktivitasPage(),
        '/petik-jeruk': (context) => const PetikJerukPage(),
        '/edukasi': (context) => const EdukasiPage(),
        '/wawancara': (context) => const WawancaraPage(),
        '/penelitian': (context) => const PenelitianPage(),
      },
    );
  }
}