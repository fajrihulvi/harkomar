import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/service/ArusApi.dart';
import 'package:amr_apps/core/service/StandMeterApi.dart';
import 'package:amr_apps/core/service/TeganganApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';
import '../../locator.dart';

class PemeriksaanKeduaModel extends BaseModel{
  ArusApi _api = locator<ArusApi>();
  TeganganApi _apiTegangan = locator<TeganganApi>();
  StandMeterApi _apiStandMeter = locator<StandMeterApi>();
  var result = Map <String,dynamic>();
  Future<Map<String,dynamic>> insertAll(String token, Map<String,dynamic>tegangan,Map<String,dynamic>arus,Map<String,dynamic>standmeter)async{
    setState(ViewState.Busy);
    result = await _api.insertArus(token, arus);
    if(result['success']==false){
      return result;
    }
    result = await _apiTegangan.insertTegangan(token, tegangan);
    if(result['success']==false){
      return result;
    }
    result = await _apiStandMeter.insertStandMeter(token, standmeter);
    if(result['success']==false){
      return result;
    }
    var map = new Map<String,dynamic>();
    map['success'] = true;
    map['msg'] = "Data berhasil di input";
    setState(ViewState.Idle);
    return map;
  }
}