import 'dart:convert';
import 'package:amr_apps/core/model/Meter.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class MeterApi {
  var apiSetting = new ApiSetting.initial();
  var client = new http.Client();
  Future<Meter> getMeterByPelanggan(String token,String pelangganID) async{
    print("Get Meter By Pelanggan....");
    print("Token : $token");
    Meter meter;
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/meter?"+"pelanggan_id="+pelangganID.toString()+"&limit=1");
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
      meter = new Meter.initial();
      return meter;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['meter']==null){
      meter = new Meter.initial();
      return meter;
    }
    meter = new Meter.fromMap(responseBody['meter']);
    return meter;
  }
  Future<Map<String,dynamic>> insertMeter(String token,Map<String,dynamic> data) async{
    print("Insert data meter....");
    print("Token : $token");
    var map = new Map<String,dynamic>();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/meter");
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