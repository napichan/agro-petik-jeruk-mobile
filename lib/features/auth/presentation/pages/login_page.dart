import 'package:flutter/gestures.dart'; // untuk TapGestureRecognizer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Kunci untuk mengakses state Form (dipakai memanggil validate()).
  final _formKey = GlobalKey<FormState>();

  // Controller untuk membaca teks yang diketik pengguna.
  final _namaCtrl = TextEditingController();
  final _sandiCtrl = TextEditingController();

  bool _isAgreed = false;
  bool _obscure = true;

  // Pendeteksi ketukan untuk teks "Daftar di sini" (TextSpan tidak bisa
  // di-tap tanpa recognizer).
  late final TapGestureRecognizer _daftarTap = TapGestureRecognizer()
    ..onTap = _keRegister;

  void _keRegister() {
    // pushReplacement, sama seperti register -> login, supaya tumpukan
    // halaman tidak menumpuk bolak-balik.
    Navigator.pushReplacementNamed(context, '/register');
  }
  final Color primaryOrange = const Color(0xFFE8550D);

  @override
  void dispose() {
    _namaCtrl.dispose();
    _sandiCtrl.dispose();
    _daftarTap.dispose();
    super.dispose();
  }

  // ---- Validator: return String = pesan error, return null = valid ----
  String? _validasiNama(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    if (value.trim().length < 3) {
      return 'Nama lengkap minimal 3 karakter';
    }
    return null;
  }

  String? _validasiSandi(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi wajib diisi';
    }
    if (value.length < 8) {
      return 'Kata sandi minimal 8 karakter';
    }
    return null;
  }

  void _onMasuk() {
    // Jalankan semua validator; berhenti kalau ada yang tidak valid.
    if (!_formKey.currentState!.validate()) return;

    if (!_isAgreed) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Centang persetujuan Syarat & Ketentuan dulu'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    // Lolos validasi -> ke Beranda (halaman login dihapus dari tumpukan).
    Navigator.pushReplacementNamed(context, '/beranda');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mulai Pengalaman Berkebun",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A202C),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Daftarkan akun untuk reservasi jadwal petik jeruk manis langsung di kebun Solorejo, Dau, Malang",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              
              // Field Nama Lengkap
              _buildInputField(
                label: "Nama Lengkap",
                hint: "Masukkan nama lengkap anda",
                icon: Icons.person_outline,
                controller: _namaCtrl,
                validator: _validasiNama,
              ),
              const SizedBox(height: 16),

              // Field Kata Sandi
              _buildInputField(
                label: "Kata sandi",
                hint: "Masukkan sandi anda",
                icon: Icons.lock_outline,
                isObscure: _obscure,
                controller: _sandiCtrl,
                validator: _validasiSandi,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              const SizedBox(height: 16),

              // Checkbox Persetujuan
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _isAgreed,
                      activeColor: primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _isAgreed = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: "Saya menyetujui "),
                          TextSpan(
                            text: "Syarat & Ketentuan",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2D3748),
                            ),
                          ),
                          const TextSpan(text: " serta "),
                          TextSpan(
                            text: "Kebijakan Privasi",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2D3748),
                            ),
                          ),
                          const TextSpan(text: " petik jeruk Solorejo."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Tombol Utama (Masuk)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _onMasuk,
                  child: Text(
                    "Masuk",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Pembatas / Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "atau daftar lebih cepat",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 20),

              // Tombol Google
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                        height: 18,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.g_mobiledata, color: Colors.red),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Daftar dengan Google",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D3748),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Footer Link
              Center(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                    children: [
                      const TextSpan(text: "Belum punya akun? "),
                      TextSpan(
                        text: "Daftar di sini",
                        recognizer: _daftarTap,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            hintStyle: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade400),
            prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryOrange),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}