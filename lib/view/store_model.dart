import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask/data/location_repository.dart';
import 'package:mask/data/store_repository.dart';
import 'package:mask/model/store.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  // 앱이 실행되면 최초 데이터를 가져오게 됨
  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();

    stores =
        await _storeRepository.fetch(position.latitude, position.longitude);
    isLoading = false;
    notifyListeners();
  }
}
