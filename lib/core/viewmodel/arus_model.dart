import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Arus.dart';
import 'package:amr_apps/core/service/ArusApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class ArusModel extends BaseModel{
  ArusApi _api = locator<ArusApi>();
  Arus arus;
  Future getArusByBA(String token, String pemeriksaanID)async{
    setState(ViewState.Busy);
    arus = await _api.getArusByBA(token, pemeriksaanID);
    print("Arus model lt : "+arus.lt);
    setState(ViewState.Idle);
  }
}