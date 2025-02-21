class Token {
  // String? accessToken;
  // String? tokenType;
  // int? expiresIn;

  // Token({this.accessToken, this.tokenType, this.expiresIn});

  // Token.fromJson(Map<String, dynamic> json) {
  //   accessToken = json['access_token'];
  //   tokenType = json['token_type'];
  //   expiresIn = json['expires_in'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['access_token'] = this.accessToken;
  //   data['token_type'] = this.tokenType;
  //   data['expires_in'] = this.expiresIn;
  //   return data;
  // }


  final String accessToken;
  final String errorDescription;
  final String tokenType;

  Token({required this.accessToken,required this.tokenType, required this.errorDescription});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      tokenType: json['token_type'] ?? '',
      accessToken: json['access_token'] ?? '',
      errorDescription: json['error_description'] ?? '',
    );
}
}