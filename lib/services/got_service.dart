import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constant.dart';
import '../models/castle.dart';

class GotService {

  Future<List<Castle>> fetchCastles() async {
    final url = Uri.https(Constant.baseUrl, '${Constant.baseUrlPath}${Constant.endPointCastles}');
    final response = await http.Client().get(url);

    if(response.statusCode == 200) {
      List<dynamic> castles = json.decode(response.body);
      List<Castle> listCastles = castles.map((castle) => Castle.fromJson(castle)).toList();
      return listCastles;
    } else {
      return [];
    }
  }

}