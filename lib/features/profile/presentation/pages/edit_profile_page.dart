import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/edit_profile_view_model.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_avatar.dart';

/// Halaman Edit Profil — desain UI "Informasi akun".
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final EditProfileViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createEditProfileViewModel()..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    await _viewModel.pickPhoto();
    if (!mounted) return;
    if (_viewModel.errorMessage != null) {
      _showMessage(_viewModel.errorMessage!);
    }
  }

  Future<void> _pickBirthDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _viewModel.birthDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1940),
      lastDate: today,
      helpText: 'Pilih Tanggal Lahir',
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: kPrimaryGreen,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) _viewModel.setBirthDate(picked);
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await _viewModel.save();
    if (!mounted) return;

    if (success) {
      _showMessage('Perubahan profil berhasil disimpan');
      // Kembalikan `true` agar halaman Profile memuat data terbaru.
      Navigator.pop(context, true);
      return;
    }

    if (_viewModel.errorMessage != null) {
      _showMessage(_viewModel.errorMessage!);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: kBgColor,
          appBar: const ProfileAppBar(title: 'Informasi akun'),
          body: _viewModel.isLoading || _viewModel.profile == null
              ? const Center(
                  child: CircularProgressIndicator(color: kPrimaryGreen),
                )
              : _buildForm(context),
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIdentityCard(),
            const SizedBox(height: 14),
            _buildPersonalDataCard(),
            const SizedBox(height: 14),
            _buildSecurityCard(),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // ── Kartu identitas ──────────────────────────────────────────────────────

  Widget _buildIdentityCard() {
    final profile = _viewModel.profile!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Row(
        children: [
          ProfileAvatar(
            initials: _viewModel.initials,
            photoBytes: _viewModel.photoBytes,
            size: 64,
            showRing: true,
            onCameraTap: _pickPhoto,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListenableBuilder(
                  listenable: _viewModel.nameController,
                  builder: (context, _) {
                    final name = _viewModel.nameController.text.trim();
                    return Text(
                      name.isEmpty ? profile.fullName : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: kTextPrimary,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: kLightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Terverifikasi',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryGreen,
                        ),
                      ),
                    ),
                    Text(
                      '• ${profile.memberSinceLabel}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: kTextMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Data pribadi ─────────────────────────────────────────────────────────

  Widget _buildPersonalDataCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(icon: Icons.person_outline_rounded, title: 'Data Pribadi'),
          const SizedBox(height: 16),
          _fieldLabel('Nama Lengkap'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _viewModel.nameController,
            validator: EditProfileViewModel.validateName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            style: _inputStyle,
            decoration: _inputDecoration(
              hint: 'Masukkan nama lengkap',
              suffixIcon: const Icon(
                Icons.check_circle,
                color: kPrimaryGreen,
                size: 19,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fieldLabel('Email', status: 'Aktif'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _viewModel.emailController,
                      validator: EditProfileViewModel.validateEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: _inputStyle,
                      decoration: _inputDecoration(
                        hint: 'nama@email.com',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fieldLabel('WhatsApp', status: 'Terhubung'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _viewModel.phoneController,
                      validator: EditProfileViewModel.validatePhone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9+\-\s]'),
                        ),
                      ],
                      style: _inputStyle,
                      decoration: _inputDecoration(
                        hint: '+62 812-3456-7890',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _fieldLabel('Tanggal Lahir'),
          const SizedBox(height: 8),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: _pickBirthDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              decoration: BoxDecoration(
                color: _inputFillColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _viewModel.birthDate == null
                          ? 'Pilih tanggal lahir'
                          : _viewModel.birthDateLabel,
                      style: _inputStyle.copyWith(
                        color: _viewModel.birthDate == null
                            ? kTextMuted
                            : kTextPrimary,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 17,
                    color: kTextSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Keamanan akun ────────────────────────────────────────────────────────

  Widget _buildSecurityCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            icon: Icons.shield_outlined,
            title: 'Keamanan Akun',
          ),
          const SizedBox(height: 8),
          _securityTile(
            title: 'Ubah Kata Sandi',
            subtitle: _viewModel.profile!.passwordUpdatedLabel,
            onTap: () => Navigator.pushNamed(context, '/edit-kata-sandi'),
          ),
        ],
      ),
    );
  }

  Widget _securityTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: kTextMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: kTextMuted,
            ),
          ],
        ),
      ),
    );
  }

  // ── Tombol simpan ────────────────────────────────────────────────────────

  Widget _buildSaveButton() {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: _viewModel.isSaving ? null : _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryGreen,
          disabledBackgroundColor: kPrimaryGreen.withValues(alpha: 0.6),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _viewModel.isSaving
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                'Simpan Perubahan',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  // ── Helper ───────────────────────────────────────────────────────────────

  static const Color _inputFillColor = Color(0xFFF6F7F9);

  static final BoxDecoration _cardDecoration = BoxDecoration(
    color: kSurfaceColor,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: kBorderColor),
  );

  static final TextStyle _inputStyle = GoogleFonts.inter(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: kTextPrimary,
  );

  Widget _sectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: kPrimaryGreen),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: kTextPrimary,
          ),
        ),
      ],
    );
  }

  Widget _fieldLabel(String text, {String? status}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: kTextPrimary,
            ),
          ),
        ),
        if (status != null)
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: kPrimaryGreen,
            ),
          ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(fontSize: 12, color: kTextMuted),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: _inputFillColor,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kPrimaryGreen, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kDangerColor, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kDangerColor, width: 1.2),
      ),
    );
  }
}
