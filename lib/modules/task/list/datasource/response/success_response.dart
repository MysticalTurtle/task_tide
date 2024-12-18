import 'package:equatable/equatable.dart';

class SuccessResponse extends Equatable {
  const SuccessResponse({required this.message});

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      message: json['message'] as String? ?? '',
    );
  }

  final String message;

  @override
  List<Object?> get props => [message];
}
