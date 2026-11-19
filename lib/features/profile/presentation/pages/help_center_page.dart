
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/entities/help_center.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/help_center_view_model.dart';
import '../widgets/profile_app_bar.dart';

/// Halaman Pusat Bantuan — kontak WhatsApp pemilik dan Call Center.
class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  late final HelpCenterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createHelpCenterViewModel()..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  // ── Aksi ─────────────────────────────────────────────────────────────────

  Future<void> _copyNumber(HelpContact contact) async {
    await Clipboard.setData(ClipboardData(text: contact.number));
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Nomor ${contact.title} berhasil disalin'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  /// Detail kontak pengelola beserta aksi salin nomor.
  void _showContactSheet(HelpContact contact) {
    final accent = _accentFor(contact.channel);
    final background = _backgroundFor(contact.channel);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: kSurfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: kBorderColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _contactIcon(contact.channel, accent, background, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.title,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            contact.subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  contact.description,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.6,
                    color: kTextSecondary,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    contact.number,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kTextPrimary,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kTextSecondary,
                          side: const BorderSide(color: kBorderColor),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Tutup',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _copyNumber(contact),
                        icon: const Icon(Icons.copy_rounded, size: 16),
                        label: Text(
                          'Salin Nomor',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: kBgColor,
          appBar: const ProfileAppBar(title: 'Pusat Bantuan'),
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    final helpCenter = _viewModel.helpCenter;

    if (helpCenter == null) {
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
        AppSizes.scrollBottomPadding,
      ),
      child: _buildContactCards(helpCenter.contacts),
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
          TextButton(
            onPressed: _viewModel.load,
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  // ── Kontak ───────────────────────────────────────────────────────────────

  Widget _buildContactCards(List<HelpContact> contacts) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < contacts.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: _buildContactCard(contacts[i])),
          ],
        ],
      ),
    );
  }

  Widget _buildContactCard(HelpContact contact) {
    return Material(
      color: kSurfaceColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _showContactSheet(contact),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 8, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _contactIcon(
                    contact.channel,
                    _accentFor(contact.channel),
                    _backgroundFor(contact.channel),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: kTextMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                contact.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                contact.subtitle,
                style: GoogleFonts.inter(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: contact.channel == HelpChannel.whatsapp
                      ? kPrimaryGreen
                      : kTextMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactIcon(
    HelpChannel channel,
    Color accent,
    Color background, {
    double size = 30,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Icon(
        channel == HelpChannel.whatsapp
            ? Icons.chat_bubble_rounded
            : Icons.call_outlined,
        size: size * 0.55,
        color: accent,
      ),
    );
  }

  Color _accentFor(HelpChannel channel) => channel == HelpChannel.whatsapp
      ? kPrimaryGreen
      : kPrimaryOrangeDark;

  Color _backgroundFor(HelpChannel channel) =>
      channel == HelpChannel.whatsapp ? kLightGreen : kLightOrange;
}
