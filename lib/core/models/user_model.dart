class UserModel {
  const UserModel({
    required this.data,
    required this.support,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        data: Data.fromMap(json['data'] as Map<String, dynamic>? ?? {}),
        support: Support.fromMap(
          json['support'] as Map<String, dynamic>? ?? {},
        ),
      );

  UserModel copyWith({
    Data? data,
    Support? support,
  }) =>
      UserModel(
        data: data ?? this.data,
        support: support ?? this.support,
      );

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'support': support.toMap(),
      };

  static const UserModel anonymous = UserModel(
    data: Data.empty(),
    support: Support.empty(),
  );

  final Data data;
  final Support support;
}

class Data {
  const Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json['id'] as int? ?? 0,
        email: json['email'] as String? ?? '',
        firstName: json['first_name'] as String? ?? '',
        lastName: json['last_name'] as String? ?? '',
        avatar: json['avatar'] as String? ?? '',
      );

  const Data.empty()
      : id = 0,
        email = '',
        firstName = '',
        lastName = '',
        avatar = '';

  Data copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      Data(
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

class Support {
  Support({
    required this.url,
    required this.text,
  });

  const Support.empty()
      : url = '',
        text = '';

  factory Support.fromMap(Map<String, dynamic> json) => Support(
        url: json['url'] as String? ?? '',
        text: json['text'] as String? ?? '',
      );

  Support copyWith({
    String? url,
    String? text,
  }) =>
      Support(
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
