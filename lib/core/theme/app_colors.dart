import 'package:flutter/material.dart';

/// Palet warna aplikasi. Semua warna widget harus diambil dari sini.
const Color kPrimaryOrange = Color(0xFFF97316);
const Color kLightOrange = Color(0xFFFFEFE3);
const Color kPrimaryGreen = Color(0xFF167D3E);

/// Hijau sangat muda untuk chip lokasi / latar ikon hijau.
const Color kLightGreen = Color(0xFFE7F5EC);
const Color kBgColor = Color(0xFFF9F9F9);
const Color kSurfaceColor = Colors.white;
const Color kBorderColor = Color(0xFFE8E8E8);
const Color kTextPrimary = Color(0xFF1F2937);
const Color kTextSecondary = Color(0xFF6B7280);
const Color kTextMuted = Color(0xFF9CA3AF);
const Color kStarColor = Color(0xFFF59E0B);
const Color kDangerColor = Color(0xFFDC2626);

// --- Fitur ulasan ---

/// Oranye tua untuk tombol utama.
const Color kPrimaryOrangeDark = Color(0xFFEA580C);

/// Kuning bintang pada halaman ulasan.
const Color kReviewStar = Color(0xFFFBBF24);

/// Cokelat/oranye tua untuk label rating pada form ulasan.
const Color kReviewRatingLabel = Color(0xFFB45309);

/// Latar chip filter yang tidak terpilih.
const Color kChipGrey = Color(0xFFF3F4F6);

/// Track progress bar rating.
const Color kTrackColor = Color(0xFFF1F2F4);

/// Latar biru lembut untuk kotak tambah foto.
const Color kSoftBlue = Color(0xFFEFF6FF);

/// Tombol hapus foto (lingkaran gelap).
const Color kOverlayDark = Color(0xCC1F2937);

/// Warna teks/ikon tombol nonaktif.
const Color kDisabledGrey = Color(0xFFD1D5DB);

/// Gradient avatar hijau (inisial RK).
const LinearGradient kAvatarGreenGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF34D399), Color(0xFF167D3E)],
);

/// Gradient avatar oranye (inisial BS).
const LinearGradient kAvatarOrangeGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFDBA74), Color(0xFFF97316)],
);

// --- Fitur chatbot (Tanya Jeruk) ---

/// Titik status online pada avatar asisten.
const Color kChatOnlineDot = Color(0xFF22C55E);

/// Latar chip AI di judul header.
const Color kChatAiChip = kLightGreen;

/// Teks hijau pada kartu tips mandor.
const Color kChatTipsText = Color(0xFF14532D);

/// Latar area gambar jeruk pada kartu rekomendasi.
const Color kChatRecommendationThumb = kLightOrange;

/// Tombol peta pada kartu rekomendasi.
const Color kChatMapButton = kChipGrey;

/// Teks tombol peta pada kartu rekomendasi.
const Color kChatMapButtonText = kTextSecondary;

/// Latar tombol kirim yang nonaktif.
const Color kChatSendDisabled = kDisabledGrey;

/// Border tipis pada kartu tips mandor.
const Color kChatTipsBorder = Color(0xFFB7E4C7);

// --- Fitur detail wisata (Petik Jeruk Langsung) ---

/// Judul navy gelap pada halaman detail wisata.
const Color kDetailTitle = Color(0xFF1C2A32);

/// Latar krem muda kartu ringkasan info.
const Color kDetailCream = Color(0xFFFBF8F1);

/// Border tipis krem pada kartu ringkasan info.
const Color kDetailCreamBorder = Color(0xFFF0ECE3);

/// Latar tombol kembali & chip di atas foto hero.
const Color kHeroOverlay = Color(0x66000000);

/// Ikon kamera hijau muda pada chip hero.
const Color kHeroCameraIcon = Color(0xFFB8E986);

/// Teks chip di atas foto hero.
const Color kHeroChipText = Colors.white;

/// Latar lingkaran ikon aktivitas hijau.
const Color kActivityToneGreen = Color(0xFFD3FFD5);

/// Latar lingkaran ikon aktivitas salmon.
const Color kActivityToneSalmon = Color(0xFFFFDBCE);

/// Latar lingkaran ikon aktivitas biru lembut.
const Color kActivityToneBlue = Color(0xFFF0F3FF);

/// Latar lingkaran ikon aktivitas hijau limau.
const Color kActivityToneLime = Color(0xFFE0F3CC);

/// Latar lingkaran ikon aktivitas teal muda.
const Color kActivityToneTeal = Color(0xFFCCFBF1);

/// Latar lingkaran ikon aktivitas kuning muda.
const Color kActivityToneYellow = Color(0xFFFEF3C7);

/// Warna ikon keranjang pada latar teal.
const Color kActivityIconTeal = Color(0xFF0F766E);

/// Latar kotak ikon fasilitas.
const Color kFacilityIconBackground = Color(0xFFEAF6EE);
