class UserResponse {
  const UserResponse({
    required this.data,
    required this.support,
  });

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        data: DataResponse.fromMap(json['data'] as Map<String, dynamic>? ?? {}),
        support: SupportResponse.fromMap(
          json['support'] as Map<String, dynamic>? ?? {},
        ),
      );

  UserResponse copyWith({
    DataResponse? data,
    SupportResponse? support,
  }) =>
      UserResponse(
        data: data ?? this.data,
        support: support ?? this.support,
      );

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'support': support.toMap(),
      };

  // User.anonymous
  static const UserResponse anonymous = UserResponse(
    data: DataResponse.empty(),
    support: SupportResponse.empty(),
  );

  final DataResponse data;
  final SupportResponse support;
}

class DataResponse {
  const DataResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory DataResponse.fromMap(Map<String, dynamic> json) => DataResponse(
        id: json['id'] as int? ?? 0,
        email: json['email'] as String? ?? '',
        firstName: json['first_name'] as String? ?? '',
        lastName: json['last_name'] as String? ?? '',
        avatar: json['avatar'] as String? ?? '',
      );

  const DataResponse.empty()
      : id = 0,
        email = '',
        firstName = '',
        lastName = '',
        avatar = '';

  DataResponse copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      DataResponse(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
      };

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
}

class SupportResponse {
  SupportResponse({
    required this.url,
    required this.text,
  });

  const SupportResponse.empty()
      : url = '',
        text = '';

  factory SupportResponse.fromMap(Map<String, dynamic> json) => SupportResponse(
        url: json['url'] as String? ?? '',
        text: json['text'] as String? ?? '',
      );

  SupportResponse copyWith({
    String? url,
    String? text,
  }) =>
      SupportResponse(
        url: url ?? this.url,
        text: text ?? this.text,
      );

  Map<String, dynamic> toMap() => {
        'url': url,
        'text': text,
      };
  final String url;
  final String text;
}
