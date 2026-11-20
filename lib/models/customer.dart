class Customer {
  final String id;
  final String name;
  final String phone;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });
}
