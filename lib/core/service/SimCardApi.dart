import 'dart:convert';
import 'package:amr_apps/core/model/SimCard.dart';
import 'package:http/http.dart' as http;

import 'ApiSetting.dart';

class SimCardApi {
  var apiSetting = new ApiSetting.initial();
  var client = new http.Client();
  Future<SimCard> getSimCardByPelanggan(String token,String pelangganID) async{
    print("Get SimCard By Pelanggan....");
    print("Token : $token");
    SimCard simCard;
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/sim_card?"+"pelanggan_id="+pelangganID.toString()+"&limit=1");
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
      simCard = new SimCard.initial();
      return simCard;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['sim_card']==null){
      simCard = new SimCard.initial();
      return simCard;
    }
    simCard = new SimCard.fromMap(responseBody['sim_card']);
    return simCard;
  }
  Future <List<SimCard>> getSimCardByNoSim(String token,String noSim) async{
    print("Get SimCard By no sim....");
    print("Token : $token");
    List<SimCard> simCard = new List();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/sim_card/cari?"+"no_sim="+noSim+"&limit=5");
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
      return null;
    }
    var responseBody =  json.decode(response.body);
    if(responseBody['sim_card']==null){
      return simCard;
    }
    var map = responseBody['sim_card'];
    for(var sim in map){
      simCard.add(SimCard.fromMap(sim));
    }
    return simCard;
  }
  Future<Map<String,dynamic>> insertSimcard(String token,Map<String,dynamic> data) async{
    print("Insert data meter....");
    print("Token : $token");
    var map = new Map<String,dynamic>();
    var url = Uri.parse(apiSetting.host+apiSetting.postfix+"/sim_card");
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