import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../widgets/app_bottom_nav.dart';

class TiketPage extends StatelessWidget {
  const TiketPage({super.key});

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
        title: Text("Tiket Saya", style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: primaryOrange.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              // Buka halaman Profile.
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: Iconify(Mdi.account_outline, color: primaryOrange, size: 20),
            )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("#SLR-20260920", style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 4),
                            Icon(Icons.copy, size: 14, color: Colors.grey.shade400),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: primaryGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              Container(width: 6, height: 6, decoration: BoxDecoration(color: primaryGreen, shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                              Text("LUNAS", style: GoogleFonts.inter(color: primaryGreen, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("PAKET KUNJUNGAN", style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 10)),
                            const SizedBox(height: 4),
                            Text("Petik Jeruk Segar", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text("Makan Sepuasnya", style: GoogleFonts.inter(color: primaryOrange, fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("JADWAL MASUK", style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 10)),
                            const SizedBox(height: 4),
                            Text("20 Sep 2026", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text("08.00 - 11.00 WIB", style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // Garis putus-putus
              Row(
                children: [
                  Container(width: 10, height: 20, decoration: const BoxDecoration(color: Color(0xFFF9F9F9), borderRadius: BorderRadius.horizontal(right: Radius.circular(20)))),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate((constraints.constrainWidth() / 8).floor(), (index) => Container(width: 4, height: 1, color: Colors.grey.shade300)),
                        );
                      },
                    ),
                  ),
                  Container(width: 10, height: 20, decoration: const BoxDecoration(color: Color(0xFFF9F9F9), borderRadius: BorderRadius.horizontal(left: Radius.circular(20)))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("TOTAL BAYAR", style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 10)),
                        const SizedBox(height: 4),
                        Text("Rp 90.000", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                    ]),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      icon: const Iconify(Mdi.qrcode_scan, color: Colors.white, size: 16),
                      label: Text("Lihat E-Tiket", style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // Bottom navigation custom (item "Tiket Saya" sedang aktif).
      bottomNavigationBar: const AppBottomNav(activeIndex: 1),
    );
  }
}