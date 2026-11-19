import 'package:flutter/material.dart';

// Import seluruh halaman aplikasi
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/verifikasi_page.dart';
import 'features/home/presentation/pages/beranda_page.dart';
import 'features/booking/presentation/pages/pesan_tiket_page.dart';
import 'features/booking/presentation/pages/detail_tiket_page.dart';
import 'features/payment/presentation/pages/pembayaran_page.dart';
import 'features/payment/presentation/pages/pembayaran_berhasil_page.dart';
import 'features/tickets/presentation/pages/tiket_saya_page.dart';
import 'features/tickets/presentation/pages/riwayat_page.dart';
import 'features/notification/presentation/pages/notifikasi_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/profile/presentation/pages/edit_profile_page.dart';
import 'features/profile/presentation/pages/help_center_page.dart';
import 'features/profile/presentation/pages/edit_password_page.dart';
import 'features/profile/presentation/pages/new_password_page.dart';
import 'features/profile/presentation/pages/reset_password_success_page.dart';
import 'features/home/presentation/pages/aktivitas_page.dart';
import 'features/informasi/presentation/pages/informasi_page.dart';
import 'features/activity/presentation/pages/petik_jeruk_page.dart';
import 'features/activity/presentation/pages/detail_wisata_page.dart';
import 'features/education/presentation/pages/edukasi_page.dart';
import 'features/education/presentation/pages/wawancara_page.dart';
import 'features/education/presentation/pages/penelitian_page.dart';
import 'features/chatbot/presentation/pages/chatbot_page.dart';

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
        '/profile': (context) => const ProfilePage(),
        '/edit-profil': (context) => const EditProfilePage(),
        '/edit-kata-sandi': (context) => const EditPasswordPage(),
        '/reset-kata-sandi-berhasil': (context) =>
            const ResetPasswordSuccessPage(),
        '/buat-kata-sandi-baru': (context) => const NewPasswordPage(),
        '/pusat-bantuan': (context) => const HelpCenterPage(),
        '/aktivitas': (context) => const AktivitasPage(),
        '/informasi': (context) => const InformasiPage(),
        '/petik-jeruk': (context) => const PetikJerukPage(),
        '/edukasi': (context) => const EdukasiPage(),
        '/wawancara': (context) => const WawancaraPage(),
        '/penelitian': (context) => const PenelitianPage(),
        '/detail-wisata': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return DetailWisataPage(
            activityId: args is String ? args : 'petik-jeruk-langsung',
          );
        },
        '/chatbot': (context) => const ChatbotPage(),
      },
    );
  }
}
