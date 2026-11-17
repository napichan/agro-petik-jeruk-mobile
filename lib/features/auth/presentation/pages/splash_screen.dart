import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register_page.dart';

/// Warna-warna utama yang dipakai di splash screen.
const Color _kOrange = Color(0xFFF97316);
const Color _kInk = Color(0xFF111827);
const Color _kMuted = Color(0xFF6B7280);
const Color _kGreenDark = Color(0xFF16A34A);
const Color _kGreenSoft = Color(0xFFDCFCE7);
const Color _kGreenBadge = Color(0xFF22C55E);

const String _kHeroAsset = 'assets/images/splash_orchard.png';

/// Splash screen aplikasi Argo Petik Jeruk.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Status bar transparan dengan ikon gelap, sesuai desain berlatar putih.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  void _onMulai() {
    // Arahkan ke halaman pendaftaran akun.
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, viewport) => SingleChildScrollView(
            // Konten bisa digulir bila layar terlalu pendek (mis. landscape),
            // namun tetap tampil penuh seperti desain di layar ponsel.
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewport.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  // Batasi lebar konten di layar lebar (tablet/desktop/web)
                  // agar proporsi desain tetap terjaga.
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),

                          // Logo aplikasi.
                          const Center(child: _AppLogo()),
                          const SizedBox(height: 16),

                          // Nama aplikasi.
                          Text(
                            'Argo Petik Jeruk',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: _kInk,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Kartu ilustrasi kebun jeruk.
                          const _HeroCard(),
                          const SizedBox(height: 20),

                          // Baris nama kebun + label "Petik Segar".
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SOLOREJO',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: _kOrange,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: _kGreenSoft,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  'Petik Segar',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _kGreenDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Deskripsi singkat.
                          Text(
                            'Nikmati Pengalaman petik jeruk langsung dari kebun '
                            'dengan pemandangan alam yang asri',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              height: 1.65,
                              color: _kMuted,
                            ),
                          ),

                          const Spacer(),

                          // Tombol utama.
                          _PrimaryButton(
                            label: 'Mulai Petualangan',
                            onTap: _onMulai,
                          ),
                          const SizedBox(height: 14),

                          // Lokasi kebun.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: _kOrange,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'Kec. Dau, Kabupaten Malang • Jawa Timur',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5,
                                    color: _kMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Logo lingkaran jeruk dengan ring putih, daun, dan badge centang hijau.
class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      height: 104,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ring putih dengan bayangan lembut.
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEAF7EE), width: 4),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14111827),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
          ),
          // Bulan jeruk.
          Positioned(
            left: 18,
            top: 18,
            child: Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFA33C), Color(0xFFF4750B)],
                ),
              ),
            ),
          ),
          // Daun di atas buah.
          const Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(Icons.eco, size: 24, color: Color(0xFF14532D)),
            ),
          ),
          // Badge centang hijau di kanan bawah.
          Positioned(
            right: -2,
            bottom: 2,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _kGreenBadge,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(Icons.check, size: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// Kartu ilustrasi kebun jeruk dengan badge "WISATA AGRO MALANG" & "Grade A".
class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    // Batasi lebar kartu agar tidak membesar di layar yang sangat lebar.
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: AspectRatio(
          aspectRatio: 380 / 260,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F111827),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _kHeroAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFE7F3EA),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.landscape,
                        size: 48,
                        color: Color(0xFF86A789),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tombol oranye besar dengan sudut membulat dan bayangan lembut.
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _kOrange.withValues(alpha: 0.35),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: _kOrange,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
