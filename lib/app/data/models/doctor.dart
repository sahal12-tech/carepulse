class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String email;
  final String phone;
  final String avatarUrl;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.email,
    required this.phone,
    this.avatarUrl = '',
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json['id'] as String,
        name: json['name'] as String,
        specialty: json['specialty'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        avatarUrl: json['avatarUrl'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'specialty': specialty,
        'email': email,
        'phone': phone,
        'avatarUrl': avatarUrl,
      };
}
