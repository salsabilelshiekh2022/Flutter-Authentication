class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? token;

  UserData(
      {this.id, this.name, this.email, this.phone, this.image, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      token: json['token'],
    );
  }
}
