/// Jenis ikon fasilitas pada detail wisata.
enum FacilityIconType { parking, toilet, hut, store }

/// Satu fasilitas yang ditampilkan pada baris kartu "Fasilitas".
class Facility {
  const Facility({required this.label, required this.icon});

  final String label;
  final FacilityIconType icon;
}
