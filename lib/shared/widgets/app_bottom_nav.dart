import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_icons.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

/// Bottom navigation bar custom yang dipakai bersama di seluruh halaman utama.
///
/// Pill putih mengambang berisi 4 item (sesuai Figma):
/// Beranda -> '/beranda' (beranda_page.dart)
/// Tiket   -> '/tiket'   (tiket_saya_page.dart)
/// Riwayat -> '/riwayat' (riwayat_page.dart)
/// Profile -> '/profile' (profile_page.dart)
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.activeIndex});

  /// Index item yang sedang aktif (0 = Beranda, 1 = Tiket,
  /// 2 = Riwayat, 3 = Profile).
  final int activeIndex;

  static const List<_NavSpec> _items = [
    _NavSpec(
      index: 0,
      icon: AppIcons.home,
      label: 'Beranda',
      route: '/beranda',
    ),
    _NavSpec(
      index: 1,
      navKey: 'nav/pesan-tiket',
      icon: AppIcons.ticket,
      label: 'Tiket',
      route: '/tiket',
    ),
    _NavSpec(
      index: 2,
      icon: AppIcons.history,
      label: 'Riwayat',
      route: '/riwayat',
    ),
    _NavSpec(
      index: 3,
      icon: AppIcons.profile,
      label: 'Profile',
      route: '/profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.navMargin,
          0,
          AppSizes.navMargin,
          AppSizes.navMargin,
        ),
        child: Container(
          height: AppSizes.navHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.navHorizontalPadding,
          ),
          decoration: BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.circular(AppSizes.navRadius),
            boxShadow: AppShadows.navPill,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [for (final item in _items) _navItem(context, item)],
          ),
        ),
      ),
    );
  }

  /// Item navigasi. Kotak ikon selalu 37x37 agar posisi label tetap sama
  /// saat item aktif maupun tidak aktif.
  /// Aktif: ikon putih 19 di kotak oranye 37 + glow.
  /// Tidak aktif: ikon SVG oranye 24.
  Widget _navItem(BuildContext context, _NavSpec spec) {
    final aktif = spec.index == activeIndex;

    return InkWell(
      key: ValueKey(spec.navKey),
      borderRadius: BorderRadius.circular(AppSizes.navItemRadius),
      onTap: () => _goTo(context, spec.route),
      child: SizedBox(
        width: AppSizes.navItemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppSizes.navActiveBox,
              height: AppSizes.navActiveBox,
              decoration: aktif
                  ? BoxDecoration(
                      color: kPrimaryOrange,
                      borderRadius: BorderRadius.circular(
                        AppSizes.navItemRadius,
                      ),
                      boxShadow: AppShadows.orangeGlow,
                    )
                  : null,
              child: Center(
                child: SvgPicture.asset(
                  spec.icon,
                  width: aktif ? AppSizes.navActiveIcon : AppSizes.navIcon,
                  height: aktif ? AppSizes.navActiveIcon : AppSizes.navIcon,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    aktif ? kSurfaceColor : kPrimaryOrange,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.navIconLabelGap),
            Text(
              spec.label,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: aktif
                  ? AppTextStyles.navLabelActive
                  : AppTextStyles.navLabel,
            ),
          ],
        ),
      ),
    );
  }

  /// Navigasi ke rute tujuan; dilewati bila sudah berada di halaman tersebut
  /// agar tumpukan halaman (stack) tidak bertambah duplikat.
  void _goTo(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name == route) return;
    Navigator.pushNamed(context, route);
  }
}

class _NavSpec {
  const _NavSpec({
    required this.index,
    required this.icon,
    required this.label,
    required this.route,
    String? navKey,
  }) : navKey = navKey ?? 'nav$route';

  final int index;
  final String navKey;
  final String icon;
  final String label;
  final String route;
}
