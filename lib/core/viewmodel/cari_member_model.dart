import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/service/api.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class CariMemberModel extends BaseModel{
  Api _api = locator<Api>();
  List<Pelanggan> pelanggan;
  Future getberitaAcara(String token, String jenis,String query)async{
    setState(ViewState.Busy);
    pelanggan = await _api.cariMember(token,jenis,query);
    setState(ViewState.Idle);
  }
}