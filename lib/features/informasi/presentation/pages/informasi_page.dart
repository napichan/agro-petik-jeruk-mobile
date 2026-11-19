import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/informasi_kebun.dart';
import '../viewmodels/informasi_view_model.dart';

/// Halaman Informasi — syarat, ketentuan petik, dan tata tertib kebun.
class InformasiPage extends StatefulWidget {
  const InformasiPage({super.key});

  @override
  State<InformasiPage> createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  late final InformasiViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createInformasiViewModel()..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: kSurfaceColor,
          appBar: AppBar(
            backgroundColor: kSurfaceColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            leadingWidth: 56,
            leading: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              onTap: () => Navigator.maybePop(context),
              child: const Padding(
                padding: EdgeInsets.only(left: AppSizes.screenHorizontal),
                child: Icon(
                  Icons.arrow_back,
                  size: 22,
                  color: kTextPrimary,
                ),
              ),
            ),
            titleSpacing: 8,
            title: Text(
              'Aturan dan info kebun',
              style: GoogleFonts.inter(
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                color: kTextPrimary,
              ),
            ),
          ),
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    final informasi = _viewModel.informasi;

    if (informasi == null) {
      return Center(
        child: _viewModel.errorMessage != null
            ? _buildErrorState()
            : const CircularProgressIndicator(color: kPrimaryGreen),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.screenHorizontal,
        4,
        AppSizes.screenHorizontal,
        32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLokasi(informasi),
          const SizedBox(height: 12),
          Text(
            informasi.judul,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            informasi.pengantar,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              height: 1.65,
              color: kTextSecondary,
            ),
          ),
          const SizedBox(height: 20),
          _buildRingkasan(informasi.ringkasan),
          const SizedBox(height: 22),
          _buildAturanHeader(informasi.aturan.length),
          const SizedBox(height: 10),
          _buildAturanCard(informasi.aturan),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _viewModel.errorMessage!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 13, color: kTextSecondary),
          ),
          const SizedBox(height: 12),
          TextButton(onPressed: _viewModel.load, child: const Text('Coba Lagi')),
        ],
      ),
    );
  }

  // ── Lokasi ───────────────────────────────────────────────────────────────

  Widget _buildLokasi(InformasiKebun informasi) {
    return Row(
      children: [
        const Icon(Icons.place_outlined, size: 13, color: kPrimaryGreen),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            informasi.lokasi.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: kPrimaryGreen,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  // ── Ringkasan operasional ────────────────────────────────────────────────

  Widget _buildRingkasan(RingkasanOperasional ringkasan) {
    return _card(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 15,
                color: kPrimaryOrange,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Ringkasan Operasional',
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: kTextPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kLightGreen,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ringkasan.status,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ringkasanItem(
            icon: Icons.schedule_rounded,
            title: ringkasan.jamOperasional,
            subtitle: ringkasan.catatanJam,
          ),
          const SizedBox(height: 14),
          _ringkasanItem(
            icon: Icons.place_outlined,
            title: ringkasan.lokasi,
            subtitle: ringkasan.alamat,
          ),
          const SizedBox(height: 14),
          _ringkasanHarga(ringkasan),
        ],
      ),
    );
  }

  Widget _ringkasanItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 15, color: kTextMuted),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  height: 1.55,
                  color: kTextMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ringkasanHarga(RingkasanOperasional ringkasan) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(
            Icons.confirmation_number_outlined,
            size: 15,
            color: kTextMuted,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: ringkasan.harga,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: kTextPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${ringkasan.satuanHarga}',
                      style: GoogleFonts.inter(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w400,
                        color: kTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                ringkasan.catatanHarga,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  height: 1.55,
                  color: kPrimaryGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Tata tertib ──────────────────────────────────────────────────────────

  Widget _buildAturanHeader(int jumlah) {
    return Row(
      children: [
        const Icon(Icons.shield_outlined, size: 15, color: kPrimaryGreen),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'Tata Tertib & Aturan Kebun',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: kTextPrimary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$jumlah Ketentuan',
          style: GoogleFonts.inter(
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            color: kTextMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildAturanCard(List<AturanKebun> aturan) {
    return _card(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < aturan.length; i++) ...[
            if (i > 0)
              const Divider(
                height: 1,
                thickness: 1,
                indent: 14,
                endIndent: 14,
                color: kBorderColor,
              ),
            _aturanItem(index: i + 1, aturan: aturan[i]),
          ],
        ],
      ),
    );
  }

  Widget _aturanItem({required int index, required AturanKebun aturan}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                '$index',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: kTextMuted,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aturan.judul,
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: kTextPrimary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  aturan.deskripsi,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    height: 1.65,
                    color: kTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Kartu bersama ────────────────────────────────────────────────────────

  Widget _card({required Widget child, required EdgeInsets padding}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorderColor),
      ),
      child: child,
    );
  }
}
