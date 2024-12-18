class AppError {
  const AppError({
    this.title = '',
    this.message = '',
    this.statusCode = 0,
  });

  const AppError.empty()
      : title = '',
        message = '',
        statusCode = 0;

  factory AppError.fromJson(Map<String, dynamic> json) {
    return AppError(
      title: json['title'] as String,
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  final String title;
  final String message;
  final int statusCode;
}
