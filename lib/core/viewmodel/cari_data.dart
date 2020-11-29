import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/service/api.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class CariDataModel extends BaseModel{
  Api _api = locator<Api>();
  List<Pelanggan> pelanggan;
  Future getData(String token, String tgl_awal, String tgl_akhir)async{
    setState(ViewState.Busy);
    pelanggan = await _api.cariData(token,tgl_awal,tgl_akhir);
    setState(ViewState.Idle);
  }
}