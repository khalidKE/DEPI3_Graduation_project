class UserModel {
  static const String defaultProfilePic =
      'https://cdn-icons-png.flaticon.com/512/9479/9479047.png';

  static const String fieldName = 'name';
  static const String fieldEmail = 'email';
  static const String fieldPhone = 'phone';
  static const String fieldAddress = 'address';
  static const String fieldProfilePic = 'profile pic';

  final String email;
  final String password;
  final String name;
  final String phone;
  final String address;
  final String profilePic;

  const UserModel({
    required this.email,
    required this.password,
    this.name = '',
    this.phone = 'none',
    this.address = 'not defined',
    this.profilePic = defaultProfilePic,
  });

  factory UserModel.empty() => const UserModel(
        email: '',
        password: '',
        name: '',
        phone: 'none',
        address: 'not defined',
      );

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    String? phone,
    String? address,
    String? profilePic,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[fieldName] as String? ?? '',
      email: json[fieldEmail] as String? ?? '',
      phone: json[fieldPhone] as String? ?? 'none',
      address: json[fieldAddress] as String? ?? 'not defined',
      profilePic: json[fieldProfilePic] as String? ?? defaultProfilePic,
      password: json['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      fieldName: name,
      fieldEmail: email,
      fieldPhone: phone,
      fieldAddress: address,
      fieldProfilePic: profilePic,
    };
  }
}
