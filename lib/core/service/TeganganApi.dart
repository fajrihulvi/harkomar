import 'dart:convert';
import 'package:amr_apps/core/model/Tegangan.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class TeganganApi {
  var apiSetting  = new ApiSetting.initial();
  var client = new http.Client();
  Future<Tegangan> getTeganganByBA(String token,String hasilPemeriksaanID) async{
    print("Get Tegangan By BA....");
    print("Token : $token");
    Tegangan tegangan;
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/tegangan?"+"hasil_pemeriksaan_id="+hasilPemeriksaanID.toString()+"&limit=1");
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
      tegangan = new Tegangan.initial();
      return tegangan;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['tegangan']==null){
      tegangan = new Tegangan.initial();
      return tegangan;
    }
    tegangan = new Tegangan.fromMap(responseBody['tegangan']);
    return tegangan;
  }
  Future<Map<String,dynamic>> insertTegangan(String token,Map<String,dynamic> data) async{
    print("Insert data tegangan....");
    print("Token : $token");
    var map = new Map<String,dynamic>();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/tegangan");
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