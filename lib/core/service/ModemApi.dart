import 'dart:convert';
import 'package:amr_apps/core/model/Modem.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class ModemApi {
  var apiSetting = new ApiSetting.initial();
  var client = new http.Client();
  Future<Modem> getModemByPelanggan(String token,String pelangganID) async{
    print("Get Modem By Pelanggan....");
    print("Token : $token");
    Modem modem;
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/modem?"+"pelanggan_id="+pelangganID.toString()+"&limit=1");
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
      modem = new Modem.initial();
      return modem;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['modem']==null){
      modem = new Modem.initial();
      return modem;
    }
    modem = new Modem.fromMap(responseBody['modem']);
    return modem;
  }
  Future<List<Modem>> getModemByNoIMEI(String token,String noImei) async{
    print("Get Modem By Pelanggan....");
    print("Token : $token");
    List<Modem> modem= new List();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/modem/cari?"+"no_imei="+noImei.toString()+"&limit=5");
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
      return modem;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['modem']==null){
      return modem;
    }
    var map = responseBody['modem'];
    for(var mdm in map){
      modem.add(Modem.fromMap(mdm));
    }
    return modem;
  }
  Future<Map<String,dynamic>> insertModem(String token,Map<String,dynamic> data) async{
    print("Insert data modem....");
    print("Token : $token");
    var map = new Map<String,dynamic>();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/modem");
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