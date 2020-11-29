import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Modem.dart';
import 'package:amr_apps/core/model/SimCard.dart';
import 'package:amr_apps/core/model/TindakLanjut.dart';
import 'package:amr_apps/core/service/ModemApi.dart';
import 'package:amr_apps/core/service/SimCardApi.dart';
import 'package:amr_apps/core/service/TindakLanjutApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';
import 'package:amr_apps/core/model/Pemeliharaan.dart';

import '../../locator.dart';

class TindakLanjutModel extends BaseModel{
  Pemeliharaan pemeliharaan;
  TindakLanjutApi _tindakLanjutApi = locator<TindakLanjutApi>();
  List<TindakLanjut> tindakLanjut;
  ModemApi _modemApi = locator<ModemApi>();
  SimCardApi _simCardApi = locator<SimCardApi>();
  List<SimCard> simcard;
  List<Modem> modem;
  var result = new Map<String,dynamic>();
  Future getPemeliharaan(String token,String beritaAcaraID,String pemeliharaanID, String idParents)async{
    setState(ViewState.Busy);
    tindakLanjut = await _tindakLanjutApi.getTindakLanjut(token, "Tindak Lanjut",beritaAcaraID, idParents);
    pemeliharaan = await _tindakLanjutApi.getPemeliharaan(token,pemeliharaanID);
    setState(ViewState.Idle);
  }
  Future <List<SimCard>> cariSimcard(String token,String noSim)async{
    simcard = await _simCardApi.getSimCardByNoSim(token, noSim);
    return simcard;
  }
  Future<List<Modem>> cariModem(String token,String noSim)async{
    modem = await _modemApi.getModemByNoIMEI(token, noSim);
    return modem;
  }
  Future<Map<String,dynamic>> insertTindakLanjut(String token,int pelangganId, int beritaAcara,
  List tindakLanjutID,List tindakLanjutCheck,
  List modem_id, List meter_id, List sim_card_id
  )async{
    setState(ViewState.Busy);
    if(result['success']==false){
      return result;
    }
    result = await _tindakLanjutApi.insertHasilPemeriksaan(token,pelangganId, beritaAcara,tindakLanjutID,tindakLanjutCheck,modem_id,meter_id,sim_card_id);
    if(result['success']==false){
      return result;
    }
    var map = new Map<String,dynamic>();
    map['success'] = true;
    map['msg'] = "Data berhasil di input";
    map['tindak_lanjut'] = result['tindak_lanjut'];
    setState(ViewState.Idle);
    return map;
  }
}