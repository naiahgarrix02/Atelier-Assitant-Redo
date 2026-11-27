class Customer {
  final String id;
  final String name;
  final String phone;
  final String? notes;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  final String? photopath;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.notes,
    this.photopath,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });
}
