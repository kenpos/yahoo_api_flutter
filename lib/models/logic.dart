import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:mvvm_hotpepper/json/JsonStruct.dart';
import 'package:mvvm_hotpepper/json/Yahooapis.dart';

class CountModel extends ChangeNotifier {
  /// 初期値
  int count = 0;
  String address = "ウマ娘";
  String res = "";

  String strtmp = "";

  /// count の更新メソッド
  void increment() {
    count++;
    changeText();
    requestSample2();
    notifyListeners();
  }

  void changeText() {
    if (count > 5) {
      address = "ウマ娘プリティーダービー";
    }
  }

  void requestSample() async {
    var uri =
        Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=0791100');

    http.Response res = await http.get(uri);
    if (res.statusCode == 200) {
      String data = res.body;
      Map<String, dynamic> map = jsonDecode(data);
      var human = Autogenerated.fromJson(map);
      // String address1 = map['results'][0]['address1'];
      strtmp = human.results[0].address1!;
      print(human.results[0].address1);
    } else {
      throw Exception('Failed to load post');
    }
  }

  void requestSample2() async {
    var uri = Uri.parse(
        'https://map.yahooapis.jp/search/local/V1/localSearch?appid=<APIコード>&output=json&query=ラーメン');
    http.Response res = await http.get(uri);
    if (res.statusCode == 200) {
      String data = res.body;
      Map<String, dynamic> map = jsonDecode(data);
      var yapi = YahooApi.fromJson(map);
      print(yapi.resultInfo.total);
      for (var i = 0; i < yapi.resultInfo.count; i++) {
        print(yapi.feature[i].name);
        String add = yapi.feature[i].property.address;
        print(yapi.feature[i].property.address);
        requestAddCoder(add);
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<void> requestAddCoder(String address) async {
    List<Location> locations = await locationFromAddress(address);
    print(locations.first.latitude);
    print(locations.first.longitude);
  }
}