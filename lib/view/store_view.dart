import 'package:flutter/foundation.dart';
import 'package:mask/data/mask_api.dart';
import 'package:mask/model/store.dart';

class StoreView with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];
  final _maskApi = MaskApi();

  StoreView() {
    fetchMaskStock();
  }

  Future fetchMaskStock() async {
    isLoading = true;
    notifyListeners();

    stores = await _maskApi.fetchMaskStock();
    isLoading = false;
    notifyListeners();
  }
}
