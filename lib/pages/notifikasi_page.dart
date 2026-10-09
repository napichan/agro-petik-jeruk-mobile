import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  final Color primaryOrange = const Color(0xFFFF7A00);
  final Color primaryGreen = const Color(0xFF1B8A44);
  final Color bgColor = const Color(0xFFF9F9F9);

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
        title: Text(
          "Notifikasi",
          style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Aktivitas Terbaru", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: primaryOrange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: Text("2 Baru", style: GoogleFonts.inter(color: primaryOrange, fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.check, color: primaryGreen, size: 16),
                    const SizedBox(width: 4),
                    Text("Tandai dibaca", style: GoogleFonts.inter(color: primaryGreen, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            _buildNotificationCard(
              iconData: Mdi.ticket_confirmation_outline,
              iconColor: primaryGreen,
              title: "E-Tiket Siap Digunakan!",
              desc: "Tiket Petik Jeruk #SLR-20260920 sudah aktif. Tunjukkan kode QR di loket...",
              time: "10 mnt lalu",
              isNew: true,
            ),
            _buildNotificationCard(
              iconData: Mdi.leaf,
              iconColor: primaryOrange,
              title: "Musim Panen Raya Jeruk Keprok 55",
              desc: "Kondisi buah di Blok A sedang manis maksimal (Brix 14.2°). Waktu terbaik...",
              time: "2 jam lalu",
              isNew: true,
            ),
            _buildNotificationCard(
              iconData: Mdi.check_circle_outline,
              iconColor: Colors.grey.shade600,
              title: "Pembayaran Berhasil Diverifikasi",
              desc: "Transfer Bank BRI sebesar Rp 40.000 telah disetujui staf loket Solorejo.",
              time: "Kemarin, 08.45 WIB",
              isNew: false,
            ),
            _buildNotificationCard(
              iconData: Mdi.tag_outline,
              iconColor: primaryOrange,
              title: "Voucher Member Setia Aktif",
              desc: "Selamat! Anda mendapat voucher potongan petik 15% untuk kunjungan berikutnya.",
              time: "3 hari lalu",
              isNew: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String iconData,
    required Color iconColor,
    required String title,
    required String desc,
    required String time,
    required bool isNew,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Iconify(iconData, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                    if (isNew) Container(width: 8, height: 8, decoration: BoxDecoration(color: primaryOrange, shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(desc, style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey.shade400),
                    const SizedBox(width: 4),
                    Text(time, style: GoogleFonts.inter(color: Colors.grey.shade400, fontSize: 10)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}