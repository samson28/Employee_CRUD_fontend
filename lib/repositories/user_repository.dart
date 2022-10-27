import 'dart:convert';

import 'package:employee_crud_fontend/model/user.dart';
import 'package:employee_crud_fontend/provider/hive_provider.dart';
import 'package:employee_crud_fontend/utilities/urls.dart';

import 'package:http/http.dart' as http;

class UserRepo {
  login(User user) async {
    var url = Uri.parse(uri + UserUrl().loginUrl());
    var response = await http.post(url,
        body: {'email': user.email, 'password': user.password},
        headers: {'Accept': 'application/json'});
    final jsonData = jsonDecode(response.body);
    HiveProvider.box.put('token', jsonData['access-token']);
    print(jsonData);
    return jsonData;
  }

  register(User user) async {
    var url = Uri.parse(uri + UserUrl().registerUrl());
    var response = await http.post(url, body: {
      'name': user.name,
      'email': user.email,
      'password': user.password
    }, headers: {
      'Accept': 'application/json'
    });
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }

  logout() async {
    var url = Uri.parse(uri + UserUrl().logoutUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response.body;
  }

  current() async {
    var url = Uri.parse(uri + UserUrl().currentUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response.body;
  }

  refresh() async {
    var url = Uri.https(uri, UserUrl().refreshUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response.body;
  }
}
