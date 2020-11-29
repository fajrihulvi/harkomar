import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Tegangan.dart';
import 'package:amr_apps/core/service/TeganganApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class TeganganModel extends BaseModel{
  TeganganApi _api = locator<TeganganApi>();
  Tegangan tegangan;
  Future getTeganganByBA(String token, String pemeriksaanID) async{
    setState(ViewState.Busy);
    tegangan = await _api.getTeganganByBA(token, pemeriksaanID);
    setState(ViewState.Idle);
  }
}