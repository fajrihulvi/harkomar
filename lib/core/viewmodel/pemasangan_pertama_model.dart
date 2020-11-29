import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Arus.dart';
import 'package:amr_apps/core/model/StandMeter.dart';
import 'package:amr_apps/core/model/Tegangan.dart';
import 'package:amr_apps/core/service/ArusApi.dart';
import 'package:amr_apps/core/service/MeterApi.dart';
import 'package:amr_apps/core/service/ModemApi.dart';
import 'package:amr_apps/core/service/SimCardApi.dart';
import 'package:amr_apps/core/service/StandMeterApi.dart';
import 'package:amr_apps/core/service/TeganganApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class PemasanganPertamaModel extends BaseModel{
  ArusApi _api = locator<ArusApi>();
  TeganganApi _apiTegangan = locator<TeganganApi>();
  StandMeterApi _apiStandMeter = locator<StandMeterApi>();
  ModemApi _modemApi = locator<ModemApi>();
  SimCardApi _simCardApi = locator<SimCardApi>();
  MeterApi _meterApi = locator<MeterApi>();
  var result = Map <String,dynamic>();
  Future<Map<String,dynamic>> insertAll(String token, Map<String,dynamic>tegangan,Map<String,dynamic>arus,Map<String,dynamic>standmeter,Map<String,dynamic>modem,Map<String,dynamic>simcard, Map<String,dynamic> meter)async{
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
    var resultModem = await _modemApi.insertModem(token, modem);
    if(resultModem['success']==false){
      return resultModem;
    }
    print("Result Modem : "+resultModem.toString());
    String modem_id = resultModem['modem_id'];
    var resultSimCard = await _simCardApi.insertSimcard(token, simcard);
    if(resultSimCard['success']==false){
      return resultSimCard;
    }
    print("Result Sim Card: "+resultSimCard.toString());
    String card_id = resultSimCard['card_id'];
    var resultMeter = await _meterApi.insertMeter(token, meter);
    if(resultMeter['success']==false){
      return resultMeter;
    }
    print("Result Meter : "+resultMeter.toString());
    String meter_id = resultMeter['meter_id'];
    var map = new Map<String,dynamic>();
    map['success'] = true;
    map['msg'] = "Data berhasil di input";
    map['modem_id'] = modem_id;
    map['card_id'] = card_id;
    map['meter_id'] = meter_id;
    setState(ViewState.Idle);
    return map;
  }
}