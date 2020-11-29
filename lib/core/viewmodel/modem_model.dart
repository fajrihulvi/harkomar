import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/SimCard.dart';
import 'package:amr_apps/core/service/SimCardApi.dart';
import 'package:amr_apps/core/model/Modem.dart';
import 'package:amr_apps/core/service/ModemApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class ModemModel extends BaseModel{
  SimCardApi _api = locator<SimCardApi>();
  SimCard simCard;
  ModemApi _apiModem = locator<ModemApi>();
  Modem modem;
  Future getDataModem(String token, String pelangganID) async{
    setState(ViewState.Busy);
    simCard = await _api.getSimCardByPelanggan(token, pelangganID);
    modem = await _apiModem.getModemByPelanggan(token, pelangganID);
    setState(ViewState.Idle);
  }
}