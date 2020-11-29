import 'dart:typed_data';

import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/service/HasilPemeriksaanApi.dart';
import 'package:amr_apps/core/service/TindakLanjutApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class SignatureModel extends BaseModel{
  TindakLanjutApi _tindakLanjutApi = locator<TindakLanjutApi>();
  HasilPemeriksaanApi _hasilPemeriksaanApi = locator<HasilPemeriksaanApi>();
  var result = new Map<String,dynamic>();
  Future<Map<String,dynamic>> updateSignature(String token ,Uint8List ttdPetugas,Uint8List ttdPelanggan,List tindak_lanjut,List hasil_pemeriksaan,int pelangganID,int woID, int id_login) async{
    
    setState(ViewState.Busy);

    result = await _tindakLanjutApi.updateSignature(token, ttdPetugas, ttdPelanggan,tindak_lanjut,pelangganID,woID,id_login);
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