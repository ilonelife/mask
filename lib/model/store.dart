class Store {
  Store({
    required this.addr,
    required this.code,
    required this.createdAt,
    required this.lat,
    required this.lng,
    required this.name,
    required this.remainStat,
    required this.stockAt,
    required this.type,
  });

  late final String addr;
  late final String code;
  late final dynamic createdAt;
  late final num lat;
  late final num lng;
  late final String name;
  late final dynamic remainStat;
  late final dynamic stockAt;
  late final String type;

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      addr: json['addr'],
      code: json['code'],
      createdAt: json['created_at'],
      lat: json['lat'],
      lng: json['lng'],
      name: json['name'],
      remainStat: json['remain_stat'],
      stockAt: json['stock_at'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['addr'] = addr;
    _data['code'] = code;
    _data['created_at'] = createdAt;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['name'] = name;
    _data['remain_stat'] = remainStat;
    _data['stock_at'] = stockAt;
    _data['type'] = type;
    return _data;
  }
}
