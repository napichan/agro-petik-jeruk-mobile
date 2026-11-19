import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';



class PesanTiketPage extends StatefulWidget {
  const PesanTiketPage({super.key});

  @override
  State<PesanTiketPage> createState() => _PesanTiketPageState();
}

class _PesanTiketPageState extends State<PesanTiketPage> {
  
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

  static const List<String> _hariPendek = [
    'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min',
  ];
  static const List<String> _hariPanjang = [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu',
  ];
  static const List<String> _bulanPendek = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  // Tahun yang bisa dipilih pada kalender.
  static const List<int> _tahunList = [2026, 2027];

  // ---- State form ----
  int _jenisDipilih = 0;
  int _sesiDipilih = 0;
  DateTime? _tanggal;
  DateTime _bulanTampil = DateTime(2026, 9);
  bool _kalenderTerbuka = true;
  int _dewasa = 2;
  int _anak = 0;
  final TextEditingController _namaCtrl = TextEditingController();
  final TextEditingController _hpCtrl = TextEditingController();

  // Kunci Form untuk memanggil validate() di tombol "Lanjut Bayar".
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _namaCtrl.dispose();
    _hpCtrl.dispose();
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

  String? _validasiHp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'No. Whatsapp / HP wajib diisi';
    }
    if (!RegExp(r'^[0-9+\-\s]{8,}$').hasMatch(value.trim())) {
      return 'No. HP tidak valid (minimal 8 digit angka)';
    }
    return null;
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

  /// Format tanggal lengkap — mis. "20 September 2026".
  String _formatTanggalLengkap(DateTime d) =>
      '${d.day} ${_bulan[d.month - 1]} ${d.year}';

  /// Format ringkasan kedatangan — mis. "Minggu, 20 Sep 2026".
  String _formatKedatangan(DateTime d) =>
      '${_hariPanjang[d.weekday - 1]}, ${d.day} '
      '${_bulanPendek[d.month - 1]} ${d.year}';

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

  // --- 2. TANGGAL KUNJUNGAN (kalender bulanan) ---
  Widget _buildTanggal() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
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
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _kalenderTerbuka = !_kalenderTerbuka),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: kPrimaryGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _tanggal == null
                          ? 'Pilih tanggal kunjungan'
                          : _formatTanggalLengkap(_tanggal!),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _tanggal == null
                            ? Colors.grey.shade500
                            : Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.edit_calendar,
                    color: kPrimaryGreen,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (_kalenderTerbuka) _buildKalender(),
        ],
      ),
    );
  }

  Widget _buildKalender() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Navigasi bulan.
          Row(
            children: [
              _navBulan(Icons.keyboard_arrow_left_rounded, -1),
              Expanded(
                child: Center(
                  // Pilihan tahun menyatu dengan judul bulan.
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _bulanTampil.year,
                      isDense: true,
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: Colors.black54,
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                      selectedItemBuilder: (context) => _tahunList
                          .map(
                            (tahun) => Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${_bulan[_bulanTampil.month - 1]} $tahun',
                              ),
                            ),
                          )
                          .toList(),
                      items: _tahunList
                          .map(
                            (tahun) => DropdownMenuItem(
                              value: tahun,
                              child: Text('$tahun'),
                            ),
                          )
                          .toList(),
                      onChanged: (tahun) {
                        if (tahun == null) return;
                        setState(() {
                          _bulanTampil = DateTime(tahun, _bulanTampil.month);
                        });
                      },
                    ),
                  ),
                ),
              ),
              _navBulan(Icons.keyboard_arrow_right_rounded, 1),
            ],
          ),
          const SizedBox(height: 8),
          // Nama hari, Sabtu & Minggu berwarna oranye.
          Row(
            children: List.generate(7, (i) {
              return Expanded(
                child: Center(
                  child: Text(
                    _hariPendek[i],
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: i >= 5 ? kPrimaryOrange : Colors.grey.shade500,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 2),
          ..._barisTanggal(),
          const SizedBox(height: 8),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 10),
          // Ringkasan kedatangan & jam buka.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.event_available_outlined,
                size: 16,
                color: kPrimaryGreen,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _tanggal == null
                      ? 'Kedatangan: belum dipilih'
                      : 'Kedatangan: ${_formatKedatangan(_tanggal!)}',
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    color: _tanggal == null
                        ? Colors.grey.shade500
                        : kPrimaryGreen,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Buka 08:00 - 16:00',
                textAlign: TextAlign.right,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  height: 1.4,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navBulan(IconData icon, int delta) {
    final berikut = DateTime(_bulanTampil.year, _bulanTampil.month + delta);
    final aktif = berikut.year >= _tahunList.first &&
        berikut.year <= _tahunList.last;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: aktif ? () => setState(() => _bulanTampil = berikut) : null,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 18,
          color: aktif ? Colors.black87 : Colors.grey.shade300,
        ),
      ),
    );
  }

  /// Baris-baris tanggal untuk bulan yang sedang ditampilkan.
  List<Widget> _barisTanggal() {
    final pertama = DateTime(_bulanTampil.year, _bulanTampil.month, 1);
    final jumlahHari = DateTime(
      _bulanTampil.year,
      _bulanTampil.month + 1,
      0,
    ).day;
    // Senin = kolom pertama.
    final offset = pertama.weekday - 1;
    final totalKolom = ((offset + jumlahHari) / 7).ceil() * 7;
    final baris = <Widget>[];

    for (int r = 0; r < totalKolom ~/ 7; r++) {
      final children = <Widget>[];
      for (int c = 0; c < 7; c++) {
        final tanggal = r * 7 + c - offset + 1;
        if (tanggal < 1 || tanggal > jumlahHari) {
          children.add(
            const Expanded(
              child: SizedBox(height: 32),
            ),
          );
          continue;
        }

        final date = DateTime(_bulanTampil.year, _bulanTampil.month, tanggal);
        final terpilih = _tanggal != null &&
            _tanggal!.year == date.year &&
            _tanggal!.month == date.month &&
            _tanggal!.day == date.day;

        children.add(
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => setState(() {
                  _tanggal = date;
                  _bulanTampil = DateTime(date.year, date.month);
                }),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: terpilih
                      ? const BoxDecoration(
                          color: kPrimaryGreen,
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Text(
                    '$tanggal',
                    style: GoogleFonts.inter(
                      fontSize: 11.5,
                      fontWeight:
                          terpilih ? FontWeight.w700 : FontWeight.w500,
                      color: terpilih ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      baris.add(Row(children: children));
    }
    return baris;
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
      child: Form(
        key: _formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama Lengkap',
            style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _namaCtrl,
            validator: _validasiNama,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: _inputDecoration('Tulis nama anda', Icons.person_outline),
          ),
          const SizedBox(height: 12),
          Text(
            'No. Whatsapp / HP',
            style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _hpCtrl,
            validator: _validasiHp,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: _inputDecoration('No.Hp', Icons.phone_outlined),
          ),
        ],
      ),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
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

  /// Validasi lalu arahkan ke halaman pembayaran.
  ///
  /// - Jumlah pengunjung (bukan field teks) dicek manual -> SnackBar.
  /// - Nama & No. HP divalidasi lewat Form (`validator` di TextFormField).
  void _lanjutBayar() {
    final jenis = _jenisList[_jenisDipilih];
    if (jenis.satuan == 'orang' && _dewasa == 0) {
      _tampilkanPesan('Minimal 1 pengunjung dewasa');
      return;
    }
    // Menjalankan semua validator; pesan error tampil di bawah tiap field.
    if (!_formKey.currentState!.validate()) return;

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

