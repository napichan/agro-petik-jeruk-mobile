import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Ukuran, radius, jarak, dan shadow bersama. Jangan hardcode di widget.
abstract final class AppSizes {
  // Jarak layar.
  static const double screenHorizontal = 20;
  static const double screenTop = 10;
  static const double scrollBottomPadding = navHeight + navMargin;
  static const double sectionGap = 24;

  // Radius umum.
  static const double radiusSm = 8;
  static const double radiusMd = 14;
  static const double radiusLg = 16;
  static const double radiusXl = 22;
  static const double radiusPill = 28;
  static const double radiusChip = 20;

  // Header beranda.
  static const double headerButton = 40;
  static const double headerIcon = 20;
  static const double backIcon = 18;
  static const double locationDot = 6;

  // Kartu menu "Jelajahi Sekarang".
  static const double menuCardHeight = 128;
  static const double menuCardGap = 12;
  static const double menuIconBox = 48;
  static const double menuIcon = 24;
  static const double menuLabelHeight = 32;

  // Kartu informasi & review.
  static const double infoCardRadius = 16;
  static const double reviewAvatar = 36;
  static const double reviewStar = 10;

  // Bottom navigation (sesuai Figma).
  static const double navMargin = 16;
  static const double navHeight = 78;
  static const double navRadius = 28;
  static const double navHorizontalPadding = 20;
  static const double navItemWidth = 59;
  static const double navItemRadius = 12;

  /// Kotak ikon item tidak aktif.
  static const double navIcon = 24;

  /// Kotak oranye item aktif beserta ikon putih di dalamnya.
  static const double navActiveBox = 37;
  static const double navActiveIcon = 19;
  static const double navIconLabelGap = 8;

  // --- Fitur ulasan ---
  static const double reviewPageHorizontal = 16;
  static const double reviewCardRadius = 18;
  static const double reviewPageAvatar = 44;
  static const double reviewVerifiedIcon = 10;
  static const double reviewListStar = 12;
  static const double reviewPhotoThumb = 64;
  static const double reviewCardGap = 12;
  static const double reviewBottomBarPadding = 14;
  static const double reviewWriteButtonHeight = 42;
  static const double reviewProfileButton = 38;
  static const double reviewProfileIcon = 19;

  // Form tulis ulasan.
  static const double reviewFormHorizontal = 16;
  static const double reviewInputRadius = 12;
  static const double reviewBigStar = 34;
  static const double reviewPhotoBox = 84;
  static const double reviewSubmitButtonHeight = 48;
  static const double reviewSubmitButtonRadius = 14;
  static const double reviewScrollBottomPadding = 120;

  // --- Fitur chatbot (Tanya Jeruk) ---
  static const double chatHeaderHeight = 62;
  static const double chatLeadingWidth = 48;
  static const double chatHeaderSpacing = 1;
  static const double chatBackIcon = 22;
  static const double chatHeaderAvatar = 40;
  static const double chatHeaderAvatarIcon = 22;
  static const double chatOnlineDot = 10;
  static const double chatOnlineBorder = 2;
  static const double chatHeaderGap = 10;
  static const double chatTitleGap = 6;
  static const double chatAiChipHeight = 17;
  static const double chatAiChipRadius = 6;
  static const double chatAiChipHorizontal = 6;
  static const double chatProfileButton = 38;
  static const double chatProfileIcon = 19;

  static const double chatPageHorizontal = 16;
  static const double chatListTop = 8;
  static const double chatDateChipHeight = 26;
  static const double chatDateChipHorizontal = 12;
  static const double chatWelcomeGap = 14;
  static const double chatMessageGap = 10;
  static const double chatScrollBottomPadding = 16;

  static const double chatBubbleRadius = 18;
  static const double chatBubbleCorner = 4;
  static const double chatBubbleHorizontal = 14;
  static const double chatBubbleVertical = 12;
  static const double chatBubbleWidthFactor = 0.8;
  static const double chatBubbleActionGap = 8;

  static const double chatSuggestChipHeight = 34;
  static const double chatSuggestChipGap = 8;
  static const double chatSuggestIcon = 14;
  static const double chatSuggestHorizontal = 12;

  static const double chatMetaIcon = 9;
  static const double chatMetaGap = 3;
  static const double chatTypingDot = 6;
  static const double chatTypingGap = 4;
  static const double chatTypingWidth = 56;
  static const double chatTypingHeight = 38;

  static const double chatCardRadius = 16;
  static const double chatCardPadding = 12;
  static const double chatCardThumb = 64;
  static const double chatCardThumbGap = 10;
  static const double chatCardRowGap = 10;
  static const double chatCardPriceGap = 4;
  static const double chatCardBodyGap = 8;
  static const double chatCardActionsGap = 12;
  static const double chatChipDotGap = 4;
  static const double chatCardThumbRadius = 12;
  static const double chatCardThumbIcon = 30;
  static const double chatTagHeight = 20;
  static const double chatTagHorizontal = 8;
  static const double chatTagRadius = 6;
  static const double chatCardChipHeight = 22;
  static const double chatCardChipDot = 5;
  static const double chatCardChipRadius = 20;
  static const double chatCardChipGap = 6;
  static const double chatCardActionHeight = 34;
  static const double chatCardActionRadius = 9;
  static const double chatCardActionGap = 8;
  static const double chatCardActionIcon = 13;

  static const double chatTipsRadius = 12;
  static const double chatTipsPadding = 11;
  static const double chatTipsIcon = 14;
  static const double chatTipsGap = 8;

  static const double chatQuickBarHeight = 32;
  static const double chatQuickBarGap = 8;
  static const double chatQuickBarVertical = 8;
  static const double chatQuickChipHorizontal = 12;

  static const double chatInputBarVertical = 10;
  static const double chatInputHeight = 48;
  static const double chatInputRadius = 24;
  static const double chatInputIcon = 20;
  static const double chatInputHorizontal = 14;
  static const double chatSendButton = 46;
  static const double chatSendIcon = 20;
  static const double chatInputGap = 8;
  static const double chatInputIconGap = 6;
  static const double chatErrorPadding = 32;
  static const double chatErrorIcon = 44;
  static const double chatErrorGap = 12;
  static const double chatErrorActionGap = 16;

  // --- Fitur detail wisata (Petik Jeruk Langsung) ---

  /// Tinggi foto hero relatif terhadap tinggi layar.
  static const double detailHeroHeightFactor = 0.30;

  /// Radius sudut atas sheet konten putih.
  static const double detailSheetRadius = 32;

  /// Jarak sheet menimpa bagian bawah foto hero.
  static const double detailSheetOverlap = 32;

  static const double detailHorizontal = 20;
  static const double detailSheetTopPadding = 12;
  static const double detailSheetBottomPadding = 24;
  static const double detailSectionGap = 24;
  static const double detailSectionTitleGap = 12;

  // Hero: tombol kembali & chip nama kebun.
  static const double detailBackButton = 40;
  static const double detailBackIcon = 20;
  static const double detailHeroHorizontal = 16;
  static const double detailHeroTop = 8;
  static const double detailChipHeight = 32;
  static const double detailChipHorizontal = 12;
  static const double detailChipIcon = 14;
  static const double detailChipGap = 6;

  // Judul & alamat.
  static const double detailTitleGap = 8;
  static const double detailInfoTopGap = 20;
  static const double detailAddressGap = 4;
  static const double detailAddressIcon = 13;
  static const double detailAddressTop = 2;

  // Kartu ringkasan info (durasi & tiket).
  static const double detailInfoRadius = 16;
  static const double detailInfoVertical = 20;
  static const double detailInfoHorizontal = 8;
  static const double detailInfoIcon = 20;
  static const double detailInfoIconGap = 6;
  static const double detailInfoLabelGap = 4;

  // Kartu daftar aktivitas.
  static const double detailActivityPadding = 12;
  static const double detailActivityIcon = 36;
  static const double detailActivityIconGap = 16;
  static const double detailActivityRowGap = 14;

  // Kartu fasilitas.
  static const double detailFacilityGap = 10;
  static const double detailFacilityMinWidth = 68;
  static const double detailFacilityHeight = 90;
  static const double detailFacilityIconBox = 38;
  static const double detailFacilityIconRadius = 12;
  static const double detailFacilityIcon = 20;
  static const double detailFacilityLabelGap = 8;

  // --- Aktivitas edukasi ---
  static const double educationActivityIcon = 32;
  static const double educationFacilityInset = 8;

  // Penanganan error.
  static const double detailErrorPadding = 28;
  static const double detailErrorIcon = 32;
  static const double detailErrorGap = 12;
  static const double detailErrorActionGap = 16;
  static const double detailErrorButtonHeight = 42;
}

/// Shadow lembut yang dipakai ulang di seluruh aplikasi.
abstract final class AppShadows {
  static const List<BoxShadow> navPill = [
    BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, 6)),
  ];

  static const List<BoxShadow> orangeGlow = [
    BoxShadow(color: Color(0x4DF97316), blurRadius: 14, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> soft = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> reviewCard = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 14, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> reviewButton = [
    BoxShadow(color: Color(0x33EA580C), blurRadius: 12, offset: Offset(0, 4)),
  ];
}

/// Gaya teks bersama (Plus Jakarta Sans, didaftarkan di pubspec.yaml).
abstract final class AppTextStyles {
  static const String fontFamily = 'PlusJakartaSans';

  static const TextStyle greeting = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: kTextPrimary,
  );

  static const TextStyle subGreeting = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: kTextPrimary,
  );

  static const TextStyle locationChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w700,
    color: kPrimaryGreen,
    letterSpacing: 0.4,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: kTextSecondary,
  );

  static const TextStyle sectionTitleGreen = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: kPrimaryGreen,
  );

  static const TextStyle sectionSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle featureChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: kPrimaryOrange,
  );

  static const TextStyle menuLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: kTextPrimary,
    height: 1.3,
  );

  static const TextStyle reviewTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: kTextPrimary,
  );

  static const TextStyle clockChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w700,
    color: kPrimaryOrange,
  );

  static const TextStyle ratingChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w800,
    color: kTextPrimary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle captionStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: kTextSecondary,
  );

  static const TextStyle link = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: kPrimaryOrange,
  );

  static const TextStyle reviewQuote = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: kTextSecondary,
    fontStyle: FontStyle.italic,
    height: 1.6,
  );

  static const TextStyle navLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w700,
    color: kPrimaryOrange,
  );

  static const TextStyle navLabelActive = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w700,
    color: kPrimaryOrange,
  );

  static const TextStyle verifiedChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8,
    fontWeight: FontWeight.w700,
    color: kPrimaryGreen,
  );

  // --- Fitur ulasan ---

  static const TextStyle reviewPageTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: kTextPrimary,
  );

  static const TextStyle reviewRatingBig = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: kTextPrimary,
    height: 1.1,
  );

  static const TextStyle reviewRatingCount = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: kTextMuted,
  );

  static const TextStyle reviewBreakdownLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: kTextSecondary,
  );

  static const TextStyle reviewBreakdownPercent = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: kTextMuted,
  );

  static const TextStyle reviewFilterChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: kTextPrimary,
  );

  static const TextStyle reviewName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.5,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
  );

  static const TextStyle reviewVerified = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w700,
    color: kPrimaryGreen,
  );

  static const TextStyle reviewMeta = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle reviewBody = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextSecondary,
    height: 1.55,
  );

  static const TextStyle reviewTicketChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: kTextSecondary,
  );

  static const TextStyle reviewHelpful = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: kTextSecondary,
  );

  static const TextStyle reviewBottomPrompt = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle reviewBottomPromptStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
  );

  static const TextStyle reviewButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle reviewSubmitButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.5,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );


  static const TextStyle reviewDoneChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: kPrimaryGreen,
  );

  static const TextStyle reviewPrompt = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
  );

  static const TextStyle reviewRatingLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: kReviewRatingLabel,
  );

  static const TextStyle reviewSectionLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
  );

  static const TextStyle reviewCounter = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: kTextMuted,
  );

  static const TextStyle reviewInput = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextPrimary,
    height: 1.5,
  );

  static const TextStyle reviewHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle reviewHelper = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9.5,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle reviewAddPhoto = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: kPrimaryGreen,
  );

  static const TextStyle reviewSwitchTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
  );

  static const TextStyle reviewSwitchSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  // --- Fitur chatbot (Tanya Jeruk) ---

  static const TextStyle chatTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: kTextPrimary,
    height: 1.2,
  );

  static const TextStyle chatSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9.5,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle chatAiChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8,
    fontWeight: FontWeight.w800,
    color: kPrimaryGreen,
    letterSpacing: 0.3,
  );

  static const TextStyle chatDateChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: kTextMuted,
  );

  static const TextStyle chatBubble = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextPrimary,
    height: 1.55,
  );

  static const TextStyle chatUserBubble = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.5,
  );

  static const TextStyle chatMeta = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8.5,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  static const TextStyle chatSuggest = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.5,
    fontWeight: FontWeight.w600,
    color: kTextPrimary,
  );

  static const TextStyle chatCardSector = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8.5,
    fontWeight: FontWeight.w800,
    color: kPrimaryOrange,
    letterSpacing: 0.3,
  );

  static const TextStyle chatCardGrade = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8.5,
    fontWeight: FontWeight.w700,
    color: kPrimaryGreen,
  );

  static const TextStyle chatCardName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: kTextPrimary,
    height: 1.2,
  );

  static const TextStyle chatCardPrice = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.5,
    fontWeight: FontWeight.w800,
    color: kPrimaryGreen,
  );

  static const TextStyle chatCardUnit = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w500,
    color: kTextMuted,
  );

  static const TextStyle chatCardChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 8.5,
    fontWeight: FontWeight.w600,
    color: kTextSecondary,
  );

  static const TextStyle chatCardBody = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: kTextSecondary,
    height: 1.5,
  );

  static const TextStyle chatCardButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: kTextSecondary,
  );

  static const TextStyle chatCardButtonGreen = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle chatTips = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: kChatTipsText,
    height: 1.5,
  );

  static const TextStyle chatTipsStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w800,
    color: kPrimaryGreen,
  );

  static const TextStyle chatInput = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextPrimary,
  );

  static const TextStyle chatInputHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: kTextMuted,
  );

  // --- Fitur detail wisata (Petik Jeruk Langsung) ---

  static const TextStyle detailTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: kDetailTitle,
    height: 1.25,
  );

  static const TextStyle detailAddress = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextSecondary,
    height: 1.5,
  );

  static const TextStyle detailChip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.5,
    fontWeight: FontWeight.w700,
    color: kHeroChipText,
  );

  static const TextStyle detailInfoLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: kTextMuted,
    letterSpacing: 0.6,
  );

  static const TextStyle detailInfoValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: kDetailTitle,
  );

  static const TextStyle detailSectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: kDetailTitle,
  );

  static const TextStyle detailActivityText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: kDetailTitle,
    height: 1.45,
  );

  static const TextStyle detailFacilityLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: kDetailTitle,
  );

  static const TextStyle educationActivityText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: kDetailTitle,
    height: 1.4,
  );

  static const TextStyle detailErrorTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: kDetailTitle,
  );

  static const TextStyle detailErrorMessage = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextSecondary,
    height: 1.5,
  );

  static const TextStyle detailRetryButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
}
