import 'dart:convert';

import 'package:employee_crud_fontend/model/user.dart';
import 'package:employee_crud_fontend/provider/hive_provider.dart';
import 'package:employee_crud_fontend/utilities/urls.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class UserRepo {
  login(String email, String password) async {
    var url = Uri.parse(uri + UserUrl().loginUrl());
    var response = await http.post(url,
        body: {'email': email, 'password': password},
        headers: {'Accept': 'application/json'});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (kDebugMode) {
      print(jsonData);
    }
    if (jsonData['status'] == 'success') {
      String x = jsonData['access_token'];
      HiveProvider.box.put('token', x);
      return 'success';
    } else {
      if (kDebugMode) {
        print('error');
      }
      return 'error';
    }
  }

  register(User user) async {
    var url = Uri.parse(uri + UserUrl().registerUrl());
    var response = await http.post(url,
        body: user.toJson(), headers: {'Accept': 'application/json'});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (kDebugMode) {
      print(jsonData);
    }
    if (jsonData['status'] == 'success') {
      HiveProvider.box.put('token', jsonData['authorisation']['access_token']);
      return 'success';
    } else {
      return 'error';
    }
  }

  logout() async {
    var url = Uri.parse(uri + UserUrl().logoutUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    return jsonData;
  }

  current() async {
    var url = Uri.parse(uri + UserUrl().currentUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }

  refresh() async {
    var url = Uri.https(uri, UserUrl().refreshUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }
}
