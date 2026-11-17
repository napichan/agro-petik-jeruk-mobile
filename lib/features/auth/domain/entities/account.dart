class Account {
  const Account({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.createdAt,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final DateTime createdAt;

  String get firstName => fullName.trim().split(RegExp(r'\s+')).first;
}
