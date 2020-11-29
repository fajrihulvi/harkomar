import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/HasilPemeriksaan.dart';
import 'package:amr_apps/core/model/KodeSegel.dart';
import 'package:amr_apps/core/model/TindakLanjut.dart';
import 'package:amr_apps/core/service/HasilPemeriksaanApi.dart';
import 'package:amr_apps/core/service/KodeSegelApi.dart';
import 'package:amr_apps/core/service/TindakLanjutApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';
class PemasanganKeduaModel extends BaseModel{
  HasilPemeriksaanApi _hasilPemeriksaanApi = locator<HasilPemeriksaanApi>();
  List<HasilPemeriksaan> hasilPemeriksaan;
  TindakLanjutApi _tindakLanjutApi = locator<TindakLanjutApi>();
  List<TindakLanjut> tindakLanjut;
  KodeSegelApi _kodeSegelApi = locator<KodeSegelApi>();
  KodeSegel kodeSegel;
  var result = new Map<String,dynamic>();
  Future getData(String token, String hasilPemeriksaanID)async{
    setState(ViewState.Busy);
    hasilPemeriksaan = await _hasilPemeriksaanApi.getHasilPemeriksaan(token, "Pasang Baru",hasilPemeriksaanID, "3");
    tindakLanjut = await _tindakLanjutApi.getTindakLanjut(token, "Tindak Lanjut Pasang Baru",hasilPemeriksaanID, "3");
    kodeSegel = await _kodeSegelApi.getKodeSegelByBA(token, hasilPemeriksaanID);
    setState(ViewState.Idle);
  }
  Future<Map<String,dynamic>> insert(String token, int beritaAcara,
  List hasilPemeriksaanID,List hasilPemeriksaanCheck,
  List tindakLanjutID,List tindakLanjutCheck,
  List modem_id, List meter_id, List sim_card_id
  )async{
    setState(ViewState.Busy);
    result = await _hasilPemeriksaanApi.insertHasilPemeriksaan(token, 
      beritaAcara.toString(),hasilPemeriksaanID,hasilPemeriksaanCheck
    );
    if(result['success']==false){
      return result;
    }
    result = await _tindakLanjutApi.insertHasilPemeriksaan(token,1, beritaAcara,tindakLanjutID,tindakLanjutCheck,modem_id,meter_id,sim_card_id);
    if(result['success']==false){
      return result;
    }
    var map = new Map<String,dynamic>();
    map['success'] = true;
    map['msg'] = "Data berhasil di input";
    setState(ViewState.Idle);
    return map;
  }
  Future<Map<String,dynamic>> insertKodeSegel(String token, Map<String,dynamic> data)async{
    setState(ViewState.Busy);
    result = await _kodeSegelApi.insertKodeSegel(token,data);
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