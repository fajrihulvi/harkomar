import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/SimCard.dart';
import 'package:amr_apps/core/service/SimCardApi.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class SimCardModel extends BaseModel{
  SimCardApi _api = locator<SimCardApi>();
  SimCard simCard;
  Future getSimCardByPelanggan(String token, String pelangganID) async{
    setState(ViewState.Busy);
    simCard = await _api.getSimCardByPelanggan(token, pelangganID);
    setState(ViewState.Idle);
  }
}