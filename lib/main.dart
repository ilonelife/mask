import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  Store? stores;
  List<Store> stores = [];
  var isLoading = true;

  Future fetchMaskStock() async {
    setState(() {
      isLoading = true;
    });

    var response = await http.get(
      Uri.parse('https://gist.githubusercontent.com/junsuk5/'
          'bb7485d5f70974deee920b8f0cd1e2f0/raw/'
          '063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json'),
    );

    if (response.statusCode == 200) {
      final jsonResult = jsonDecode(response.body)['stores'];
      setState(() {
        stores.clear();
        jsonResult.forEach((e) {
          stores.add(Store.fromJson(e));
        });
        //  return jsonResult.map((e) => Store.fromJson(e)).toList();
        isLoading = false;
      });
      print('페치 완료');
    } else {
      throw Exception('Fail to load');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMaskStock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마스크 재고 있는 곳 : ${stores.where((e) {
            return e.remainStat == 'plenty' ||
                e.remainStat == 'some' ||
                e.remainStat == 'few';
          }).length} 곳',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: fetchMaskStock,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading == true
          ? loadingWidget()
          : ListView(
              children: stores.where((e) {
                return e.remainStat == 'plenty' ||
                    e.remainStat == 'some' ||
                    e.remainStat == 'few';
              }).map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: _buildRemainStatWidget(e),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    if (store.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    }
    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30~100개 이상';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2~30개 이상';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description),
      ],
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
