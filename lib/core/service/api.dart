import 'dart:convert';
import 'dart:core';
import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/Pemeliharaan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/model/WorkOrder.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class Api {
  static const host = "http://harkomar.com";
  static const postfix = "/amr-api";
  var client = new http.Client();
  var apiSetting = new ApiSetting.initial();
  Future<User> login(String username, String password) async {
    var _url = apiSetting.host + apiSetting.postfix + "/auth/login";
    print("URL : {$_url}");
    var response = await http.post(_url, headers: {
      'Content-type': 'application/x-www-form-urlencoded',
    }, body: {
      "username": username,
      "password": password
    });
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    return User.fromMap(json.decode(response.body));
  }

  Future<User> me(String token) async {
    var _url = apiSetting.host + apiSetting.postfix + "/auth/me";
    print("URL : {$_url}");
    var response = await http.get(_url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = json.decode(response.body);
    return User.fromMap(map);
  }

  Future<bool> logout(String token) async {
    var _url = apiSetting.host + apiSetting.postfix + "/auth/logout";
    print("Token : {$token}");
    var response = await http.get(_url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = json.decode(response.body);
    return map['success'];
  }

  Future<List<WorkOrder>> getWorkOrder(String token) async {
    print("Get Work Order");
    print("Token : $token");
    var workOrder = List<WorkOrder>();
    var url = Uri.parse(apiSetting.host + apiSetting.postfix + "/work_order?");
    print("URL : $url");
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = new Map<String, dynamic>();
    map = json.decode(response.body);
    if (map['data'] == null) {
      return null;
    }
    var parsed = map['data'] as List<dynamic>;
    for (var wo in parsed) {
      print("WO $wo");
      workOrder.add(WorkOrder.fromMap(wo));
    }
    return workOrder;
  }

  Future<List<Pelanggan>> getPelangganByWO(
      String token, String nomorWO, int jenis) async {
    print("Get Pelanggan By WO");
    print("Token : $token");
    var pelanggan = List<Pelanggan>();
    var url = Uri.parse(apiSetting.host +
        apiSetting.postfix +
        "/work_order/pelanggan?" +
        "&nomor_wo=" +
        nomorWO.toString() +
        "&jenis=" +
        jenis.toString());
    print("URL : $url");
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = new Map<String, dynamic>();
    map = json.decode(response.body);
    if (map['data'] == null) {
      return null;
    }
    var parsed = map['data'] as List<dynamic>;
    for (var beritaAcara in parsed) {
      print("WO $beritaAcara");
      pelanggan.add(Pelanggan.fromMap(beritaAcara));
    }
    return pelanggan;
  }

  Future<List<Pelanggan>> pelangganByWO(String token, int jenis) async {
    print("Get Pelanggan By WO");
    print("Token : $token");
    var pelanggan = List<Pelanggan>();
    var url = Uri.parse(apiSetting.host +
        apiSetting.postfix +
        "/work_order/history?" +
        "&jenis=" +
        jenis.toString());
    print("URL : $url");
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = new Map<String, dynamic>();
    map = json.decode(response.body);
    if (map['data'] == null) {
      return null;
    }
    var parsed = map['data'] as List<dynamic>;
    for (var beritaAcara in parsed) {
      
      pelanggan.add(Pelanggan.fromMap(beritaAcara));
    }
    return pelanggan;
  }

  Future<List<Berita_Acara>> getHistoryByWo(String token,
      String jenisPemeliharaan, String tgl_awal, String tgl_akhir) async {
    print("Get Pelanggan By WO");
    print("Token : $token");
    var pelanggan = List<Berita_Acara>();
    var url = Uri.parse(apiSetting.host +
        apiSetting.postfix +
        "/berita_acara/history?" +
        "&jenis_pemeliharaan=" +
        jenisPemeliharaan.toString() +
        "&tgl_awal=" +
        tgl_awal.toString() +
        "&tgl_akhir=" +
        tgl_akhir.toString());
    print("URL : $url");
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;

    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = new Map<String, dynamic>();
    map = json.decode(response.body);
    if (map['data'] == null) {
      return null;
    }
    var parsed = map['data'] as List<dynamic>;
    for (var beritaAcara in parsed) {
      print("WO $beritaAcara");
      pelanggan.add(Berita_Acara.fromWorkOrder(beritaAcara));
    }
    return pelanggan;
  }

  Future<List<Pelanggan>> cariData(
      String token, String tgl_awal, String tgl_akhir) async {
    var pelanggan = List<Pelanggan>();
    var url = Uri.parse(apiSetting.host +
        apiSetting.postfix +
        "/work_order/cari?" +
        "&tgl_awal=" +
        tgl_awal +
        "&tgl_akhir=" +
        tgl_akhir);
    print("URL : $url");
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('BODY: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = new Map<String, dynamic>();
    map = json.decode(response.body);
    if (map['data'] == null) {
      return null;
    }
    var parsed = map['data'] as List<dynamic>;
    for (var work_order in parsed) {
      print("WORK ORDER :  $work_order");
      pelanggan.add(Pelanggan.fromMap(work_order));
    }

    return pelanggan;
  }

  Future<List<Pelanggan>> cariMember(
      String token, String jenisPemeliharaan, String query) async {
    print("Get Pelanggan By WO");
    print("Token : $token");
    var pelanggan = List<Pelanggan>();
    var url = Uri.parse(apiSetting.host +
        apiSetting.postfix +
        "/berita_acara/cari_member?" +
        "jenis_pemeliharaan=" +
        jenisPemeliharaan.toString() +
        "&query=" +
        query);
    print("URL : $url");
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var map = new Map<String, dynamic>();
    map = json.decode(response.body);
    if (map['data'] == null) {
      return null;
    }
    var parsed = map['data'] as List<dynamic>;
    for (var beritaAcara in parsed) {
      print("WO $beritaAcara");
      pelanggan.add(Pelanggan.fromMap(beritaAcara));
    }
    return pelanggan;
  }

  Future<Map<String, dynamic>> changePassword(
      String token, String password, String oldPassword) async {
    var _url = apiSetting.host + apiSetting.postfix + "/user/password";
    print("URL : {$_url}");
    var response = await http.post(_url, headers: {
      "Authorization": token,
    }, body: {
      "old_password": oldPassword,
      "password": password
    });
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return json.decode(response.body);
    }
    return json.decode(response.body);
  }

  Future<Pemeliharaan> getPemeliharaan(
      String token, String pemeliharaanIDw) async {
    print("Get Pemeliharaan By ID....");
    print("Token : $token");
    Pemeliharaan pemeliharaan;
    var url = Uri.parse(apiSetting.host +
        apiSetting.postfix +
        "/pemeliharaan?" +
        "pemeliharaan_id=" +
        pemeliharaanIDw.toString() +
        "&limit=1");
    print("URL : $url");
    var response = await http.get(url,
        headers: {"Authorization": token, "Content-Type": "application/json"});
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if (statusCode < 200 || statusCode >= 400) {
      print("An Error Occured : [Status Code : $statusCode]");
      return null;
    }
    var responseBody = json.decode(response.body);
    if (responseBody['pemeliharaan'] == null) {
      return null;
    }
    pemeliharaan = new Pemeliharaan.fromMap(responseBody['pemeliharaan']);
    return pemeliharaan;
  }
}
