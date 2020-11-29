import 'dart:convert';

import 'package:amr_apps/core/model/Arus.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class ArusApi {
  static const host = "http://harkomar.com";
  static const postfix = "/amr";
  var apiSetting = ApiSetting.initial();
  var client = new http.Client();
  Future<Arus> getArusByBA(String token,String hasilPemeriksaanID) async{
    print("Get Arus By BA....");
    print("Token : $token");
    Arus arus;
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/arus?"+"hasil_pemeriksaan_id="+hasilPemeriksaanID.toString()+"&limit=1");
    print("URL : $url");
    var response = await http.get(url,
      headers: {
        "Authorization" : token,
        "Content-Type" : "application/json"
      }
    );
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if(statusCode < 200 || statusCode >= 400){
      print("An Error Occured : [Status Code : $statusCode]");
      arus = new Arus.initial();
      return arus;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['arus'] == null){
      arus = new Arus.initial();
      return arus;
    }
    arus = new Arus.fromMap(responseBody['arus']);
    return arus;
  }
  Future<Map<String,dynamic>> insertArus(String token,Map<String,dynamic> data) async{
    print("Insert data arus....");
    print("Token : $token");
    var map = new Map<String,dynamic>();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/arus");
    print("URL : $url");
    var response = await http.post(url,
      headers: {
        "Authorization" : token,
      },
      body: data
    );
    final statusCode = response.statusCode;
    print('body: [${response.body}]');
    if(statusCode < 200 || statusCode >= 400){
      print("An Error Occured : [Status Code : $statusCode]");
    }
    var responseBody =  json.decode(response.body);
    map = responseBody;
    return map;
  }
}