import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Meter.dart';
import 'package:amr_apps/core/service/MeterApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class MeterModel extends BaseModel{
  MeterApi _api = locator<MeterApi>();
  Meter meter;
  Future getMeterByPelanggan(String token, String pelangganID) async{
    setState(ViewState.Busy);
    meter = await _api.getMeterByPelanggan(token, pelangganID);
    setState(ViewState.Idle);
  }
}