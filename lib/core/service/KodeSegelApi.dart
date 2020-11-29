import 'dart:convert';
import 'package:amr_apps/core/model/KodeSegel.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class KodeSegelApi {
  var apiSetting = new ApiSetting.initial();
  var client = new http.Client();
  Future<KodeSegel> getKodeSegelByBA(String token,String hasilPemeriksaanID) async{
    print("Get KodeSegel By BA....");
    print("Token : $token");
    KodeSegel kodeSegel;
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/kode_segel?"+"hasil_pemeriksaan_id="+hasilPemeriksaanID.toString()+"&limit=1");
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
      kodeSegel = new KodeSegel.initial();
      return kodeSegel;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['kode_segel']==null){
      kodeSegel = new KodeSegel.initial();
      return kodeSegel;
    }
    kodeSegel = new KodeSegel.fromMap(responseBody['kode_segel']);
    return kodeSegel;
  }
  Future<Map<String,dynamic>> insertKodeSegel(String token,Map<String,dynamic> data) async{
    print("Insert data kode_segel....");
    print("Token : $token");
    var map = new Map<String,dynamic>();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/kode_segel");
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