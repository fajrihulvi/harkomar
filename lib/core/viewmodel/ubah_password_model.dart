import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/service/api.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class UbahPasswordModel extends BaseModel{
  Api _api = locator<Api>();
  var result = new Map<String,dynamic>();
  Future changePassword(String token,String password, String oldPassword) async{
    setState(ViewState.Busy);
    result = await _api.changePassword(token, password, oldPassword);
    setState(ViewState.Idle);
  }
}