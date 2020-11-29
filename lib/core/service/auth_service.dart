import 'dart:async';

import 'package:amr_apps/core/helper/dbhelper.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/locator.dart';

import 'api.dart';
class AuthService{
  Api _api = locator<Api>();
  StreamController<User> userController = StreamController<User>();
  DatabaseHelper dbHelper = DatabaseHelper();
  Future <bool> login (String username,String password)async{
    var user = await _api.login(username, password);
    var hasUser = user != null;
    if(hasUser){
      bool addDB = await this.addUser(user);
      if(addDB){
        userController.add(user);
      }
      else{
        return false;
      }
    }
    print("${user}");
    return hasUser;
  }
  Future <bool> checkLogin ()async{
    var user = await this.getUser();
    var hasUser = user != null;
    if(hasUser){
      print("Result from DB :"+user.toMap().toString());
      var userApi = await _api.me(user.token);
      var notLoginApi = userApi !=null;
      if(notLoginApi){
        userController.add(user);
      }
      else{
        await dbHelper.deleteUsers(user.username);
      }
      return notLoginApi;
    }
    print("${user}");
    return hasUser;
  }
  Future <bool> logout () async{
    var user = await this.getUser();
    var hasUser = user != null;
    if(hasUser){
     var delete = await dbHelper.deleteUsers(user.username);
     if(delete > 0){
       var deleteApi = await _api.logout(user.token);
       if(deleteApi){
         return true;
       }
       else{
         return false;
       }
     }
    }
    print("${user}");
    return false;
  }
  //buat user
  Future<bool> addUser(User object) async {
    var dbFuture = await dbHelper.db;
    if(dbFuture != null){
      print("Init db sukses");
      int result = await dbHelper.saveUser(object);
      if (result > 0) {
        return true;
      }
      return false;
    }
    return false;
  }
  Future<User> getUser() async{
    var dbFuture = await dbHelper.db;
    if(dbFuture != null){
      print("Init db sukses");
      var result = await dbHelper.getUser();
      if(result==null){
        return null;
      }
      else{
        var user = new User.fromDB(result);
        return user;
      }
    }
    return null;
  }
}