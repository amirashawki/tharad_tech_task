class AuthModel {
  final String? username;
  final String? email;
  final String? image;
  final int? otp;
  final String? message;
  final String? status;
  final String? token;

  AuthModel({
    this.username,
    this.email,
    this.image,
    this.otp,
    this.message,
    this.status,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      otp: json['otp'] is int ? json['otp'] : int.tryParse(json['otp']?.toString() ?? ''),
      message: json['message'] as String?,
      status: json['status'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'image': image,
    'otp': otp,
    'message': message,
    'status': status,
    'token': token,
  };
}
