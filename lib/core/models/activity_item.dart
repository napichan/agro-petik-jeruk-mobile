/// Jenis ikon untuk satu baris aktivitas.
enum ActivityIconType {
  check,
  checkGreen,
  scissors,
  pruning,
  mountain,
  guide,
  recycle,
  pest,
  basket,
  book,
  document,
  observation,
  data,
  farmer,
}

/// Nada warna latar lingkaran ikon aktivitas (dipetakan ke warna theme
/// di layer presentasi, sehingga domain tidak bergantung pada Flutter).
enum ActivityTone { green, salmon, blue, lime, teal, yellow }

/// Satu aktivitas yang ditampilkan pada kartu "Aktivitas".
class ActivityItem {
  const ActivityItem({
    required this.text,
    required this.icon,
    required this.tone,
  });

  final String text;
  final ActivityIconType icon;
  final ActivityTone tone;
}
