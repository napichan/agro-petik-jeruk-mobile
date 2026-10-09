import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class DetailTiketPage extends StatelessWidget {
  const DetailTiketPage({super.key});

  final Color primaryGreen = const Color(0xFF006D44);
  final Color bgColor = const Color(0xFFF9F9FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Tiket Saya", style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Kontainer utama tiket
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 5))],
              ),
              child: Column(
                children: [
                  // Bagian Header
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Iconify(Mdi.alert_circle_outline, color: Colors.deepOrange, size: 14),
                              const SizedBox(width: 4),
                              Text("TIKET MASUK & PETIK KEBUN", style: GoogleFonts.inter(color: Colors.deepOrange, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text("Agro Wisata Jeruk Solorejo", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1A202C))),
                        const SizedBox(height: 8),
                        Text(
                          "Jl. Watu Gede, RT.010/RW.2, Selorejo, Kec. Dau,\nKabupaten Malang.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade500, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  
                  // Efek Sobekan Tiket (Notch)
                  Row(
                    children: [
                      Container(width: 15, height: 30, decoration: BoxDecoration(color: bgColor, borderRadius: const BorderRadius.horizontal(right: Radius.circular(30)))),
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate((constraints.constrainWidth() / 8).floor(), (index) => Container(width: 4, height: 1.5, color: Colors.grey.shade300)),
                          );
                        }),
                      ),
                      Container(width: 15, height: 30, decoration: BoxDecoration(color: bgColor, borderRadius: const BorderRadius.horizontal(left: Radius.circular(30)))),
                    ],
                  ),
                  
                  // Detail Pesanan
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildRowInfo("Nama Pemesan", "Joe Malone"),
                        _buildRowInfo("Tanggal", "20 September 2026"),
                        _buildRowInfo("Waktu", "08.00 - 09.00"),
                        _buildRowInfo("Jumlah Orang", "2 orang"),
                        _buildRowInfo("Tujuan Kunjungan", "Petik Jeruk Langsung"),
                        _buildRowInfo("Harga", "Rp 20.000 / orang"),
                      ],
                    ),
                  ),

                  // Divider Dotted
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate((constraints.constrainWidth() / 6).floor(), (index) => Container(width: 3, height: 1, color: Colors.grey.shade300)),
                      );
                    }),
                  ),

                  // Detail Pembayaran
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildRowInfo("Metode Pembayaran", "DANA", isBoldValue: true),
                        _buildRowInfo("No. Ref", "023456790"),
                        _buildRowInfo("Tanggal Transaksi", "20 September 2026"),
                        _buildRowInfo("Waktu Transaksi", "08.24 WIB"),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Harga", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text("Rp 40.000", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: primaryGreen)),
                          ],
                        )
                      ],
                    ),
                  ),

                   // Divider Dotted
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate((constraints.constrainWidth() / 6).floor(), (index) => Container(width: 3, height: 1, color: Colors.grey.shade300)),
                      );
                    }),
                  ),

                  // Section QR Code
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Dummy QR Image Box
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png"),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("#APJ0206901200001", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700, letterSpacing: 1.5)),
                            const SizedBox(width: 8),
                            Iconify(Mdi.content_copy, color: Colors.grey.shade500, size: 14),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: 6, height: 6, decoration: BoxDecoration(color: primaryGreen, shape: BoxShape.circle)),
                              const SizedBox(width: 6),
                              Text("Tiket Aktif", style: GoogleFonts.inter(color: primaryGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Tunjukkan kode QR ini kepada petugas di loket\npintu masuk kebun jeruk.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade500, height: 1.5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {},
                    icon: Iconify(Mdi.download_outline, color: Colors.grey.shade700, size: 18),
                    label: Text("Simpan PDF", style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: primaryGreen.withValues(alpha: 0.3)),
                      backgroundColor: primaryGreen.withValues(alpha: 0.05)
                    ),
                    onPressed: () {},
                    icon: Iconify(Mdi.share_variant_outline, color: primaryGreen, size: 18),
                    label: Text("Bagikan", style: GoogleFonts.inter(color: primaryGreen, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfo(String label, String value, {bool isBoldValue = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 12)),
          Text(
            value, 
            style: GoogleFonts.inter(
              color: const Color(0xFF2D3748), 
              fontSize: 12, 
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.w500
            )
          ),
        ],
      ),
    );
  }
}