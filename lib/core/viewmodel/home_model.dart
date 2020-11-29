import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/WorkOrder.dart';
import 'package:amr_apps/core/service/api.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';

import '../../locator.dart';

class HomeModel extends BaseModel{
  Api _api = locator<Api>();
  List<WorkOrder> workOrder;
  Future getWorkOrder(String token)async{
    setState(ViewState.Busy);
    workOrder = await _api.getWorkOrder(token);
    setState(ViewState.Idle);
  }
}