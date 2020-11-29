import 'package:amr_apps/core/enum/userstate.dart';
import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/viewmodel/login_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/home_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'login_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model)=>model.checkLogin(),
      builder: (context,model,child)=>Scaffold(
        body: model.state == ViewState.Busy ? 
        Center(child: SplashScreen(
        seconds: 5,
        image: new Image.asset(
          'assets/images/logo.png',
          width: 300,
          height: 300,
        ),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 80.0,
        gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.9
            ],
            colors: [
              primaryColor2,
              primaryColor1
            ]),
        loadingText: Text(
          "Please Wait...",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        loaderColor: Colors.white)) : this.body(model) ,
      )
    );
  }

  Widget body(LoginModel model){
    return  model.userState == UserState.NotAuth ? 
        LoginScreen() : HomeDashboard();
  }
}