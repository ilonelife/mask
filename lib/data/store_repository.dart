import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mask/model/store.dart';

class StoreRepository {
  Future<List<Store>> fetch(double lat, double lng) async {
    List<Store> stores = [];

    var response = await http.get(
      Uri.parse('https://gist.githubusercontent.com/junsuk5/'
          'bb7485d5f70974deee920b8f0cd1e2f0/raw/'
          '063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json'),
    );

    print('$lat, $lng');

    if (response.statusCode == 200) {
      final jsonResult = jsonDecode(response.body)['stores'];

      jsonResult.forEach(
        (e) {
          stores.add(Store.fromJson(e));
        },
      );
    } else {
      throw Exception('Fail to load');
    }
    return stores.where((e) {
      return e.remainStat == 'plenty' ||
          e.remainStat == 'some' ||
          e.remainStat == 'few';
    }).toList();
  }
}
