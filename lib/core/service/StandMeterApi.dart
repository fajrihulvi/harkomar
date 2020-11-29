import 'dart:convert';
import 'package:amr_apps/core/model/StandMeter.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class StandMeterApi {
  var apiSetting = new ApiSetting.initial();
  var client = new http.Client();
  Future<StandMeter> getStandMeterByBA(String token,String hasilPemeriksaanID) async{
    print("Get StandMeter By BA....");
    print("Token : $token");
    StandMeter stand_meter;
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/stand_meter?"+"hasil_pemeriksaan_id="+hasilPemeriksaanID.toString()+"&limit=1");
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
      stand_meter = new StandMeter.initial();
      return stand_meter;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['stand_meter']==null){
      stand_meter = new StandMeter.initial();
      return stand_meter;
    }
    stand_meter = new StandMeter.fromMap(responseBody['stand_meter']);
    return stand_meter;
  }
  Future<Map<String,dynamic>> insertStandMeter(String token,Map<String,dynamic> data) async{
    print("Insert data stand_meter....");
    print("Token : $token");
    var map = new Map<String,dynamic>();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/stand_meter");
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