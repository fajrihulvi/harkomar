import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/KodeSegel.dart';
import 'package:amr_apps/core/service/KodeSegelApi.dart';

import '../../locator.dart';
import 'base_model.dart';

class PemeriksaanKetigaModel extends BaseModel{
  KodeSegelApi _kodeSegelApi = locator<KodeSegelApi>();
  KodeSegel kodeSegel;
  var result = new Map<String,dynamic>();
  Future getKodeSegel(String token, String hasilPemeriksaanID)async{
    setState(ViewState.Busy);
    kodeSegel = await _kodeSegelApi.getKodeSegelByBA(token, hasilPemeriksaanID);
    setState(ViewState.Idle);
  }
  Future<Map<String,dynamic>> insert(String token, Map<String,dynamic> data)async{
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