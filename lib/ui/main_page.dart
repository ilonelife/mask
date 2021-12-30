import 'package:flutter/material.dart';
import 'package:mask/ui/remain_stat_list_tile.dart';
import 'package:mask/view/store_view.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeView = Provider.of<StoreView>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마스크 재고 있는 곳 : ${storeView.stores.length} 곳',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              storeView.fetchMaskStock();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: storeView.isLoading == true
          ? loadingWidget()
          : ListView(
              children: storeView.stores.map((e) {
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
