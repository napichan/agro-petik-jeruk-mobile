import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/profile_update.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';

/// State dan logic halaman Edit Profil.
class EditProfileViewModel extends ChangeNotifier {
  EditProfileViewModel(this._getProfile, this._updateProfile);

  final GetProfile _getProfile;
  final UpdateProfile _updateProfile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  UserProfile? _profile;
  DateTime? _birthDate;
  Uint8List? _photoBytes;
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isPickingPhoto = false;
  String? _errorMessage;

  UserProfile? get profile => _profile;
  DateTime? get birthDate => _birthDate;
  Uint8List? get photoBytes => _photoBytes ?? _profile?.photoBytes;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isPickingPhoto => _isPickingPhoto;
  String? get errorMessage => _errorMessage;

  String get fullName => nameController.text.trim();
  String get initials => UserProfile.initialsOf(
        fullName.isEmpty ? (_profile?.fullName ?? '') : fullName,
      );

  /// Label tanggal lahir yang sedang dipilih pada form.
  String get birthDateLabel {
    final date = _birthDate;
    return date == null ? '-' : UserProfile.formatShortDate(date);
  }

  // ── Validasi (dipakai juga oleh TextFormField di halaman) ──────────────

  static String? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Nama lengkap wajib diisi';
    if (name.length < 3) return 'Nama lengkap minimal 3 karakter';
    return null;
  }

  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email wajib diisi';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) return 'Nomor telepon wajib diisi';
    if (!RegExp(r'^[0-9+\-\s]{8,}$').hasMatch(phone)) {
      return 'Nomor telepon tidak valid';
    }
    return null;
  }

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final profile = _profile = await _getProfile();
      nameController.text = profile.fullName;
      emailController.text = profile.email;
      phoneController.text = profile.phone;
      _birthDate = profile.birthDate;
      _photoBytes = profile.photoBytes;
    } catch (_) {
      _errorMessage = 'Gagal memuat profil.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setBirthDate(DateTime date) {
    _birthDate = date;
    notifyListeners();
  }

  /// Membuka galeri untuk memilih foto profil baru.
  Future<void> pickPhoto() async {
    if (_isPickingPhoto || _isSaving) return;
    _isPickingPhoto = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1024,
      );
      if (picked != null) {
        _photoBytes = await picked.readAsBytes();
      }
    } catch (_) {
      _errorMessage = 'Gagal memilih foto. Coba lagi.';
    } finally {
      _isPickingPhoto = false;
      notifyListeners();
    }
  }

  /// Menyimpan perubahan. Mengembalikan `true` bila berhasil.
  Future<bool> save() async {
    if (_isSaving) return false;

    final validationError = validateName(nameController.text) ??
        validateEmail(emailController.text) ??
        validatePhone(phoneController.text);
    if (validationError != null) {
      _errorMessage = validationError;
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profile = await _updateProfile(
        ProfileUpdate(
          fullName: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          birthDate: _birthDate,
          photoBytes: _photoBytes,
        ),
      );
      return true;
    } catch (_) {
      _errorMessage = 'Gagal menyimpan perubahan. Coba lagi.';
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
