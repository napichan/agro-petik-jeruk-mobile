import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class PembayaranBerhasilPage extends StatelessWidget {
  const PembayaranBerhasilPage({super.key});

  final Color primaryGreen = const Color(0xFF006D44);
  final Color bgColor = const Color(0xFFF1F1F1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: primaryGreen, shape: BoxShape.circle),
                    child: const Icon(Icons.check, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 16),
                  Text("Pembayaran Berhasil!", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF1A202C))),
                  const SizedBox(height: 8),
                  Text("Minggu, 20 Sep 2026 • 08:35 WIB", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Rp 40.000", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: primaryGreen)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.tealAccent.shade400.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                        child: Text("LUNAS", style: GoogleFonts.inter(color: Colors.teal.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Kode Pemesanan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("KODE PEMESANAN", style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade500)),
                          const SizedBox(height: 4),
                          Text("#SLR-20260920-804", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        onPressed: () {},
                        icon: Iconify(Mdi.content_copy, color: Colors.grey.shade700, size: 14),
                        label: Text("Salin", style: GoogleFonts.inter(color: Colors.black87, fontSize: 12)),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
                  
                  // Detail Information
                  _buildDetailRow("Paket", "Petik Jeruk Langsung", isBoldValue: true),
                  _buildDetailRow("Peserta", "2 Orang Dewasa"),
                  _buildDetailRow("Tanggal", "20 Sep 2026 (08.00)"),
                  _buildDetailRow("Metode", "Transfer BRI", iconData: Mdi.bank_outline),
                  
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/detail-tiket'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Lihat E-Tiket Masuk", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    // Kembali ke halaman beranda.
                    onPressed: () => Navigator.pushNamed(context, '/beranda'),
                    child: Text("Kembali ke Beranda", style: GoogleFonts.inter(color: Colors.brown.shade700, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(height: 16),
                  
                  // Footer note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Iconify(Mdi.whatsapp, color: primaryGreen, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "E-tiket aktif & QR code telah terbit dan dikirim otomatis ke WhatsApp Anda.",
                            style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade600),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBoldValue = false, String? iconData}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12)),
          Row(
            children: [
              if (iconData != null) ...[
                Iconify(iconData, color: primaryGreen, size: 14),
                const SizedBox(width: 4),
              ],
              Text(
                value, 
                style: GoogleFonts.inter(
                  color: const Color(0xFF2D3748), 
                  fontSize: 12, 
                  fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}