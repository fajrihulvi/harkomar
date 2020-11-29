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

class PemeriksaanPertamaModel extends BaseModel{
  ModemApi _modemApi = locator<ModemApi>();
  SimCardApi _simCardApi = locator<SimCardApi>();
  MeterApi _meterApi = locator<MeterApi>();
  var result = Map <String,dynamic>();
  Future<Map<String,dynamic>> insertAll(String token,Map<String,dynamic>modem,Map<String,dynamic>simcard, Map<String,dynamic> meter)async{
    setState(ViewState.Busy);
    result = await _modemApi.insertModem(token, modem);
    if(result['success']==false){
      return result;
    }
    print("Result Modem : "+result.toString());
    String modem_id = result['modem_id'];
    result = await _simCardApi.insertSimcard(token, simcard);
    if(result['success'] == false){
      return result;
    }
    print("Result Sim Card: "+result.toString());
    String card_id = result['card_id'];
    result = await _meterApi.insertMeter(token, meter);
    if(result['success']==false){
      return result;
    }
    print("Result Meter : "+result.toString());
    String meter_id = result['meter_id'];
    var map = new Map<String,dynamic>();
    map['success'] = true;
    map['msg'] = "Data berhasil di input";
    map['card_id'] = card_id;
    map['modem_id'] = modem_id;
    map['meter_id'] = meter_id;
    setState(ViewState.Idle);
    return map;
  }
}