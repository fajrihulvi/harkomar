import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/StandMeter.dart';
import 'package:amr_apps/core/service/StandMeterApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class StandMeterModel extends BaseModel{
  StandMeterApi _api = locator<StandMeterApi>();
  StandMeter standMeter;
  Future getStandMeterByBA(String token, String pemeriksaanID)async{
    setState(ViewState.Busy);
    standMeter = await _api.getStandMeterByBA(token, pemeriksaanID);
    setState(ViewState.Idle);
  }
}