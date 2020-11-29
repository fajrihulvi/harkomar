import 'package:amr_apps/core/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/model/User.dart';
import 'locator.dart';
import 'router.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:flutter/services.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User>(
        initialData: User.initial(),
        builder: (context) => locator<AuthService>().userController,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primaryColor1,
            accentColor: primaryColor1,
          ),
          initialRoute: 'auth',
          onGenerateRoute: Router.generateRoute,
        ));
  }
}
