import 'dart:convert';

import 'package:employee_crud_fontend/model/employee.dart';
import 'package:employee_crud_fontend/provider/hive_provider.dart';
import 'package:employee_crud_fontend/utilities/urls.dart';
import 'package:http/http.dart' as http;

class EmployeRepo {
  addEmploye(Employe employe) async {
    var url = Uri.parse(uri + EmployeUrl().addUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.post(url, body: employe.toJson(), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }

  getEmploye(Employe employe) async {
    var url = Uri.parse(uri + EmployeUrl().getUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    var list = jsonData['employes'] as List;
    List<Employe> listDesEmploye =
        list.map((i) => Employe.fromJson(i)).toList();

    return listDesEmploye;
  }

  getOneEmploye(Employe employe) async {
    var url = Uri.parse(uri + EmployeUrl().getOneUrl(employe.id));
    var token = HiveProvider.box.get('token');
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    return Employe.fromJson(jsonData['employe']);
  }

  shearchEmploye(String tips) async {
    var url = Uri.parse(uri + EmployeUrl().searchUrl());
    var token = HiveProvider.box.get('token');
    var response = await http.post(url, body: {
      "tips": tips
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    var list = jsonData['employe'] as List;
    List<Employe> listDesEmploye =
        list.map((i) => Employe.fromJson(i)).toList();

    return listDesEmploye;
  }

  updateEmploye(Employe employe) async {
    var url = Uri.parse(uri + EmployeUrl().updateUrl(employe.id));
    var token = HiveProvider.box.get('token');
    var response = await http.put(url, body: employe.toJson(), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }

  deleteEmploye(Employe employe) async {
    var url = Uri.parse(uri + EmployeUrl().deleteUrl(employe.id));
    var token = HiveProvider.box.get('token');
    var response = await http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }
}
