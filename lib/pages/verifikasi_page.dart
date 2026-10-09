import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import 'beranda_page.dart';

/// Warna yang dipakai di halaman verifikasi.
const Color _kOrange = Color(0xFFF97316);
const Color _kOrangeDeep = Color(0xFFEA580C);
const Color _kInk = Color(0xFF111827);
const Color _kMuted = Color(0xFF6B7280);
const Color _kGreen = Color(0xFF22C55E);
const Color _kGreenRing = Color(0xFFDCFCE7);

/// Halaman "Validasi daftar" — konfirmasi akun berhasil dibuat.
class VerifikasiPage extends StatefulWidget {
  const VerifikasiPage({super.key, this.account});

  /// Akun yang baru saja didaftarkan (opsional, dari penyimpanan dummy).
  final Account? account;

  @override
  State<VerifikasiPage> createState() => _VerifikasiPageState();
}

class _VerifikasiPageState extends State<VerifikasiPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  /// Teks sapaan yang dipersonalisasi bila data akun tersedia.
  String get _welcomeText {
    final account = widget.account;
    if (account == null) {
      return 'Selamat datang di Agro Wisata Jeruk Solorejo. '
          'Akun Anda siap digunakan untuk memesan tiket '
          'dan menikmati pengalaman memetik jeruk '
          'langsung dari pohonnya.';
    }
    return 'Selamat datang, ${account.firstName}!\n'
        'Akun Anda siap digunakan untuk memesan tiket '
        'dan menikmati pengalaman memetik jeruk '
        'langsung dari pohonnya.';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: FadeTransition(
                      opacity: _fade,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Ikon centang dengan oranye + daun.
                          _SuccessBadge(scale: _scale),
                          const SizedBox(height: 28),

                          // Judul sukses.
                          Text(
                            'Akun Berhasil Dibuat!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: _kInk,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Deskripsi (dengan sapaan nama bila ada).
                          Text(
                            _welcomeText,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 12.5,
                              height: 1.7,
                              color: _kMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tombol utama.
                  _PrimaryButton(
                    label: 'Mulai Jelajahi Wisata',
                    hasArrow: true,
                    onPressed: () {
                      // Arahkan ke halaman beranda dan bersihkan stack
                      // navigasi agar tidak bisa kembali ke sini.
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const BerandaPage()),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Badge sukses: cincin hijau muda dengan centang putih di lingkaran hijau,
/// dihiasi buah jeruk oranye dan daun kecil di sisinya.
class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge({required this.scale});

  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SizedBox(
        width: 150,
        height: 130,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Cincin hijau muda latar.
            Positioned(
              left: 15,
              top: 5,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _kGreenRing,
                ),
              ),
            ),
            // Lingkaran hijau utama.
            Positioned(
              left: 35,
              top: 25,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _kGreen,
                  boxShadow: [
                    BoxShadow(
                      color: _kGreen.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.check, size: 42, color: Colors.white),
              ),
            ),
            // Buah jeruk oranye.
            const Positioned(right: 6, top: 0, child: _OrangeFruit(size: 26)),
            // Daun hijau kecil kiri bawah.
            const Positioned(
              left: 2,
              bottom: 18,
              child: Icon(Icons.eco, size: 22, color: Color(0xFF16A34A)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Buah jeruk oranye sederhana (lingkaran bergradasi + daun).
class _OrangeFruit extends StatelessWidget {
  const _OrangeFruit({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(top: size * 0.15),
            width: size * 0.85,
            height: size * 0.85,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFA33C), _kOrangeDeep],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Icon(Icons.eco, size: size * 0.45, color: Color(0xFF16A34A)),
          ),
        ],
      ),
    );
  }
}

/// Tombol oranye besar bergradasi dengan panah.
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onPressed,
    this.hasArrow = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool hasArrow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(colors: [_kOrange, _kOrangeDeep]),
          boxShadow: [
            BoxShadow(
              color: _kOrange.withValues(alpha: 0.35),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (hasArrow) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Colors.white,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
