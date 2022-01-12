import 'package:flutter/material.dart';
import 'package:mask/ui/remain_stat_list_tile.dart';
import 'package:mask/view/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel =
        context.watch<StoreModel>(); //Provider.of<StoreView>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마스크 재고 있는 곳 : ${storeModel.stores.length} 곳',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              storeModel.fetch();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: storeModel.isLoading == true
          ? loadingWidget()
          : ListView(
              children: storeModel.stores.map((e) {
                return RemainStatListTile(store: e);
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('정보를 가져오는 중...'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
