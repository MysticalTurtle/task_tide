import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  const RegisterResponse({
    required this.id,
    required this.token,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        id: json['id'] as int? ?? 0,
        token: json['token'] as String? ?? '',
      );

  final int id;
  final String token;

  @override
  List<Object?> get props => [id, token];
}
