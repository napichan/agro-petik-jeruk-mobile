import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final Color primaryGreen = const Color(0xFF006D44);
  final Color bgColor = const Color(0xFFF9F9FB);
  final Color borderColor = Colors.grey.shade200;

  int _selectedPayment = 0; // 0: BRI, 1: QRIS, 2: Tunai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              // Buka halaman Profile.
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: const Iconify(Mdi.account_outline, color: Colors.orange, size: 20),
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pembayaran", style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF1A202C))),
            const SizedBox(height: 24),
            
            // Card Pesanan
            _buildOrderCard(),
            const SizedBox(height: 16),

            // Card Rincian Biaya
            _buildCostDetails(),
            const SizedBox(height: 24),

            // Metode Pembayaran
            Text("Metode Pembayaran", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1A202C))),
            const SizedBox(height: 16),
            _buildPaymentOption(0, "Transfer Bank BRI", isExpanded: true),
            const SizedBox(height: 12),
            _buildPaymentOption(1, "QRIS"),
            const SizedBox(height: 12),
            _buildPaymentOption(2, "Bayar Tunai di Loket"),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildOrderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Iconify(Mdi.ticket_confirmation_outline, color: primaryGreen, size: 20),
                  const SizedBox(width: 8),
                  Text("Petik Jeruk Langsung", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: primaryGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                child: Text("2 Orang", style: GoogleFonts.inter(color: primaryGreen, fontSize: 12, fontWeight: FontWeight.w600)),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jadwal", style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 11)),
                  const SizedBox(height: 4),
                  Text("Minggu, 20 Sep 2026 •\nPagi", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pemesan", style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 11)),
                  const SizedBox(height: 4),
                  Text("Joe Malone", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCostDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rincian Biaya", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
              Text("#SLR-20260920", style: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          _detailRow("Tiket Masuk (2x)", "Rp 40.000", isBoldText: true),
          const SizedBox(height: 8),
          _detailRow("Biaya Layanan", "Rp 0", valueColor: primaryGreen),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Tagihan", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
              Text("Rp 40.000", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }

  Widget _detailRow(String title, String value, {bool isBoldText = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12)),
        Text(
          value, 
          style: GoogleFonts.inter(
            color: valueColor ?? Colors.black87, 
            fontSize: 12, 
            fontWeight: isBoldText ? FontWeight.bold : FontWeight.normal
          )
        ),
      ],
    );
  }

  Widget _buildPaymentOption(int index, String title, {bool isExpanded = false}) {
    bool isSelected = _selectedPayment == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: isSelected ? primaryGreen : borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: isSelected ? primaryGreen : Colors.grey.shade400, width: 2),
                      ),
                      child: isSelected 
                        ? Center(child: Container(width: 10, height: 10, decoration: BoxDecoration(color: primaryGreen, shape: BoxShape.circle))) 
                        : null,
                    ),
                    const SizedBox(width: 12),
                    Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                if (index == 0) // Menyesuaikan dengan dummy desain
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: primaryGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                    child: Text("Manual", style: GoogleFonts.inter(color: primaryGreen, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
              ],
            ),
            if (isSelected && isExpanded) ...[
              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0012-01-098765-53-0", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.5)),
                      const SizedBox(height: 4),
                      Text("a.n. Agro Jeruk Solorejo", style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: primaryGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Iconify(Mdi.content_copy, color: primaryGreen, size: 14),
                        const SizedBox(width: 4),
                        Text("Salin", style: GoogleFonts.inter(color: primaryGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("TOTAL BAYAR", style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
                Text("Rp 40.000", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                Text("2 Pengunjung (2 Dewasa)", style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade500)),
              ],
            ),
            ElevatedButton(
              // Navigasi ke halaman pembayaran berhasil.
              onPressed: () => Navigator.pushNamed(context, '/pembayaran-berhasil'), 
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                children: [
                  Text("Bayar", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}