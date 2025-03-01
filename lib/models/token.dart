class Token {
  final String accessToken;
  final String errorDescription;
  final String expiresIn;
  final String tokenType;

  Token({
    required this.accessToken,
    required this.tokenType, 
    required this.errorDescription,
    required this.expiresIn,
    });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      tokenType: json['token_type'] ?? '',
      accessToken: json['access_token'] ?? '',
      errorDescription: json['error_description'] ?? '',
      expiresIn: DateTime.now().add(Duration(seconds: json['expires_in'] )).toString(),
    );
}
}