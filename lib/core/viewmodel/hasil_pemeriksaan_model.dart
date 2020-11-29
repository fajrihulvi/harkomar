import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/HasilPemeriksaan.dart';
import 'package:amr_apps/core/model/Pemeliharaan.dart';
import 'package:amr_apps/core/service/HasilPemeriksaanApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';
class HasilPemeriksaanModel extends BaseModel{
  HasilPemeriksaanApi _hasilPemeriksaanApi = locator<HasilPemeriksaanApi>();
  List<HasilPemeriksaan> hasilPemeriksaan;
  Pemeliharaan pemeliharaan;
  var result = new Map<String,dynamic>();

  Future getPemeliharaan(String token,String beritaAcaraID,String pemeliharaanID, String idParents)async{
    setState(ViewState.Busy);
    hasilPemeriksaan = await _hasilPemeriksaanApi.getHasilPemeriksaan(token, "Pemeriksaan",beritaAcaraID, idParents);
    pemeliharaan = await _hasilPemeriksaanApi.getPemeliharaan(token,pemeliharaanID);
    setState(ViewState.Idle);
  }
  
  Future<Map<String,dynamic>> insertHasilPemeriksaan(String token, String beritaAcara,
  List hasilPemeriksaanID,List hasilPemeriksaanCheck
  )async{
    setState(ViewState.Busy);
    result = await _hasilPemeriksaanApi.insertHasilPemeriksaan(token, 
      beritaAcara,hasilPemeriksaanID,hasilPemeriksaanCheck
    );
    if(result['success']==false){
      return result;
    }
    var map = new Map<String,dynamic>();
    map['success'] = true;
    map['msg'] = "Data berhasil di input";
    map['hasil_pemeriksaan'] = result['hasil_pemeriksaan'];
    setState(ViewState.Idle);
    return map;
  }
}