import 'dart:convert';

import 'package:disal_entregas/helpers/constans.dart';
import 'package:disal_entregas/models/response.dart';
import 'package:http/http.dart' as http;

class Apihelper {

  static Future<Response> post(String opcion, String token) async {
   var url = Uri.parse("${Constans.apiUrlTest}/api/Sync/Consultas");
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'Opcion':opcion}),
    );
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: response.body);
    }
    return Response(isSuccess: true, result: jsonDecode(response.body), message: 'Ok');
  }
}
