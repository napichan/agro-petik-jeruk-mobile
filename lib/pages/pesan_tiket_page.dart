import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'beranda_page.dart';

/// Halaman Pesan Tiket — form pemesanan tiket masuk kebun jeruk Solorejo.
/// Sesuai desain UI: jenis kunjungan, tanggal, sesi waktu, jumlah
/// pengunjung, data pengunjung, dan ringkasan total bayar.
class PesanTiketPage extends StatefulWidget {
  const PesanTiketPage({super.key});

  @override
  State<PesanTiketPage> createState() => _PesanTiketPageState();
}

class _PesanTiketPageState extends State<PesanTiketPage> {
  // ---- Data jenis kunjungan (nama, harga, satuan) ----
  static const List<({String nama, int harga, String satuan})> _jenisList = [
    (nama: 'Petik Jeruk Langsung', harga: 20000, satuan: 'orang'),
    (nama: 'Edukasi Wisata', harga: 35000, satuan: 'orang'),
    (nama: 'Wawancara Petani', harga: 50000, satuan: 'sesi'),
    (nama: 'Penelitian Lapangan', harga: 200000, satuan: 'pkt'),
  ];

  // ---- Sesi waktu kunjungan ----
  static const List<({String label, String jam})> _sesiList = [
    (label: 'Pagi', jam: '08.00-10.00'),
    (label: 'Siang', jam: '10.00-12.00'),
    (label: 'Sore', jam: '12.00-14.00'),
    (label: 'Sore', jam: '14.00-16.00'),
  ];

  static const List<String> _bulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  // ---- State form ----
  int _jenisDipilih = 0;
  int _sesiDipilih = 0;
  DateTime _tanggal = DateTime(2026, 9, 20);
  int _dewasa = 2;
  int _anak = 0;
  final TextEditingController _namaCtrl = TextEditingController();
  final TextEditingController _hpCtrl = TextEditingController();

  @override
  void dispose() {
    _namaCtrl.dispose();
    _hpCtrl.dispose();
    super.dispose();
  }

  // ---- Total & format ----
  int get _total {
    final jenis = _jenisList[_jenisDipilih];
    return jenis.satuan == 'orang' ? jenis.harga * _dewasa : jenis.harga;
  }

  String _rupiah(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      buf.write(s[i]);
      final sisa = s.length - i - 1;
      if (sisa > 0 && sisa % 3 == 0) buf.write('.');
    }
    return 'Rp $buf';
  }

  String _formatTanggal(DateTime d) =>
      '${d.day} ${_bulan[d.month - 1]} ${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sectionTitle('1.', 'Jenis Kunjungan'),
                    _buildJenisKunjungan(),
                    _sectionTitle('2.', 'Tanggal Kunjungan'),
                    _buildTanggal(),
                    _sectionTitle('3.', 'Sesi Waktu'),
                    _buildSesi(),
                    _sectionTitle('4.', 'Jumlah Pengunjung'),
                    _buildJumlahPengunjung(),
                    _sectionTitle('5.', 'Data Pengunjung'),
                    _buildDataPengunjung(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // --- HEADER (kembali, ikon akun, judul, subjudul) ---
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black87,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryOrange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  // Buka halaman Profile.
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                  child: const Iconify(
                    Mdi.account_outline,
                    color: kPrimaryOrange,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Pesan Tiket',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: kPrimaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Tiket masuk kebun jeruk Solorejo, Dau Malang',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Judul section bernomor dengan titik hijau ---
  Widget _sectionTitle(String nomor, String judul) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Text(
            '$nomor  $judul',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: kPrimaryGreen,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  // --- 1. JENIS KUNJUNGAN (pilihan radio) ---
  Widget _buildJenisKunjungan() {
    return Column(
      children: List.generate(_jenisList.length, (i) {
        final jenis = _jenisList[i];
        final terpilih = i == _jenisDipilih;
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => setState(() => _jenisDipilih = i),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: terpilih
                  ? Border.all(color: kPrimaryGreen, width: 1.2)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _radioBubble(terpilih),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    jenis.nama,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: terpilih ? FontWeight.w700 : FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: _rupiah(jenis.harga),
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: ' /${jenis.satuan}',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// Bola radio: hijau isi centang saat terpilih, abu saat tidak.
  Widget _radioBubble(bool terpilih) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: terpilih ? kPrimaryGreen : Colors.white,
        border: Border.all(
          color: terpilih ? kPrimaryGreen : Colors.grey.shade400,
          width: 1.5,
        ),
      ),
      child: terpilih
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : null,
    );
  }

  // --- 2. TANGGAL KUNJUNGAN (date picker) ---
  Widget _buildTanggal() {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: _pilihTanggal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: kPrimaryGreen, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _formatTanggal(_tanggal),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.edit_calendar, color: kPrimaryGreen, size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _pilihTanggal() async {
    final dipilih = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2026, 9, 20),
      lastDate: DateTime(2027, 12, 31),
    );
    if (dipilih != null) {
      setState(() => _tanggal = dipilih);
    }
  }

  // --- 3. SESI WAKTU (chip pilihan) ---
  Widget _buildSesi() {
    return Row(
      children: List.generate(_sesiList.length, (i) {
        final sesi = _sesiList[i];
        final terpilih = i == _sesiDipilih;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _sesiDipilih = i),
            child: Container(
              margin: EdgeInsets.only(right: i < _sesiList.length - 1 ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: terpilih ? kPrimaryOrange : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: terpilih ? kPrimaryOrange : Colors.grey.shade300,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    sesi.label,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: terpilih ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sesi.jam,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: terpilih
                          ? Colors.white.withValues(alpha: 0.85)
                          : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // --- 4. JUMLAH PENGUNJUNG (stepper interaktif) ---
  Widget _buildJumlahPengunjung() {
    final jenis = _jenisList[_jenisDipilih];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _barisPengunjung(
            nama: 'Dewasa',
            keterangan: '${_rupiah(jenis.harga)} / ${jenis.satuan}',
            jumlah: _dewasa,
            onChanged: (v) => setState(() => _dewasa = v),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          _barisPengunjung(
            nama: 'Anak-anak',
            keterangan: '< 3 tahun gratis',
            jumlah: _anak,
            onChanged: (v) => setState(() => _anak = v),
          ),
        ],
      ),
    );
  }

  Widget _barisPengunjung({
    required String nama,
    required String keterangan,
    required int jumlah,
    required ValueChanged<int> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  keterangan,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          _stepper(jumlah, onChanged),
        ],
      ),
    );
  }

  /// Stepper [- jumlah +]: minus putih, plus hijau.
  Widget _stepper(int jumlah, ValueChanged<int> onChanged) {
    return Row(
      children: [
        _tombolStepper(
          ikon: Icons.remove,
          aktif: jumlah > 0,
          onTap: jumlah > 0 ? () => onChanged(jumlah - 1) : null,
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$jumlah',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _tombolStepper(
          ikon: Icons.add,
          aktif: true,
          hijau: true,
          onTap: () => onChanged(jumlah + 1),
        ),
      ],
    );
  }

  Widget _tombolStepper({
    required IconData ikon,
    required bool aktif,
    required VoidCallback? onTap,
    bool hijau = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: hijau ? kPrimaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: hijau
              ? null
              : Border.all(
                  color: aktif ? Colors.grey.shade400 : Colors.grey.shade200,
                ),
        ),
        child: Icon(
          ikon,
          size: 16,
          color: hijau
              ? Colors.white
              : (aktif ? Colors.grey.shade700 : Colors.grey.shade300),
        ),
      ),
    );
  }

  // --- 5. DATA PENGUNJUNG (form nama & no. HP) ---
  Widget _buildDataPengunjung() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama Lengkap',
            style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _namaCtrl,
            textInputAction: TextInputAction.next,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: _inputDecoration('Joe Malone', Icons.person_outline),
          ),
          const SizedBox(height: 12),
          Text(
            'No. Whatsapp / HP',
            style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _hpCtrl,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: _inputDecoration('0812-3456-7890', Icons.phone_outlined),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData ikon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        fontSize: 13,
        color: Colors.grey.shade400,
      ),
      prefixIcon: Icon(ikon, size: 18, color: Colors.grey.shade500),
      filled: true,
      fillColor: const Color(0xFFF7F8F9),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kPrimaryGreen),
      ),
    );
  }

  // --- BOTTOM BAR: TOTAL BAYAR + LANJUT BAYAR ---
  Widget _buildBottomBar() {
    final jenis = _jenisList[_jenisDipilih];
    final perOrang = jenis.satuan == 'orang';
    final pengunjung = _dewasa + _anak;
    final detail = perOrang
        ? '$_dewasa Dewasa${_anak > 0 ? ' + $_anak Anak-anak' : ''}'
        : '1 ${jenis.satuan}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'TOTAL BAYAR',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _rupiah(_total),
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '$pengunjung Pengunjung ($detail)',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _lanjutBayar,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lanjut Bayar',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Validasi sederhana lalu arahkan ke halaman pembayaran.
  void _lanjutBayar() {
    final jenis = _jenisList[_jenisDipilih];
    if (jenis.satuan == 'orang' && _dewasa == 0) {
      _tampilkanPesan('Minimal 1 pengunjung dewasa');
      return;
    }
    if (_namaCtrl.text.trim().isEmpty) {
      _tampilkanPesan('Isi nama lengkap terlebih dahulu');
      return;
    }
    if (_hpCtrl.text.trim().isEmpty) {
      _tampilkanPesan('Isi No. Whatsapp / HP terlebih dahulu');
      return;
    }
    Navigator.pushNamed(context, '/pembayaran');
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(pesan),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
