class Response {
  bool isSuccess;
  String message;
  dynamic result;

  Response({
    required this.isSuccess,
    required this.message,
    this.result,
  });

  // Método para convertir un JSON a un objeto Response
  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      isSuccess: json['isSuccess'],
      message: json['message'] ?? '',
      result: json['result'],
    );
  }

  // Método para convertir un objeto Response a JSON
  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'message': message,
      'result': result,
    };
  }
}
