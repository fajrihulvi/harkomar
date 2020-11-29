import 'package:amr_apps/core/enum/userstate.dart';
import 'package:amr_apps/core/service/auth_service.dart';
import 'package:amr_apps/core/viewmodel/base_model.dart';
import 'package:amr_apps/core/enum/viewstate.dart';

import '../../locator.dart';
class LoginModel extends BaseModel{
  final AuthService _authService = locator<AuthService>();
  String errorMsg;
  Future<bool>login(String username, String password) async{
    setState(ViewState.Busy);
    var success = await _authService.login(username,password);
    if(username == null || password == null){
      errorMsg = "username atau password null";
      setState(ViewState.Idle);
      return false;
    }
    setState(ViewState.Idle);
    return success;
  }
  Future<bool>checkLogin() async{
    setState(ViewState.Busy);
    var success = await _authService.checkLogin();
    if(success){
      setUserState(UserState.Auth);
    }
    setState(ViewState.Idle);
    return success;
  }
  Future<bool>logout() async{
    setState(ViewState.Busy);
    var success = await _authService.logout();
    if(success){
      setUserState(UserState.NotAuth);
    }
    setState(ViewState.Idle);
    return success;
  }
}