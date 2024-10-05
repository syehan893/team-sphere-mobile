// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthException {
  final String message;
  final dynamic statusCode;
  final String? errorCode;

  AuthException({
    required this.message,
    this.statusCode,
    this.errorCode,
  });

  AuthException copyWith({
    String? message,
    dynamic statusCode,
    String? errorCode,
  }) {
    return AuthException(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
