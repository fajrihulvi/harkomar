import 'package:amr_apps/core/enum/userstate.dart';
import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:flutter/foundation.dart';

class BaseModel extends ChangeNotifier{
  ViewState _state = ViewState.Idle;
  ViewState get state=>_state;
  UserState _userState = UserState.NotAuth;
  UserState get userState => _userState;
  void setState(ViewState state){
    _state = state;
    notifyListeners();
  }
  void setUserState(UserState state){
    _userState = state;
    notifyListeners();
  }
}