import 'dart:async';

import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/login_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/login_screen.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog pr;

  void _alertdialog(String str) {
    if (str.isEmpty) return;
    AlertDialog alertDialog = new AlertDialog(
      elevation: 5,
      title: new Text(
        "Informasi",
        style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
      content: new Text(
        str,
        style: new TextStyle(fontSize: 16.0),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: primaryColor2,
          child: new Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    primaryColor1),
              ),
              SizedBox(
                width: 15,
              ),
              Text("Please Wait ..."),
            ],
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 3), () async {
      Navigator.pop(context); //pop dialog
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
    });
  }

  Future<bool> _keluar() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        elevation: 3,
        title: new Text('Informasi'),
        content: new Text('Apakah anda yakin ingin keluar dari aplikasi ?'),
        actions: <Widget>[
          new FlatButton(
            color: Colors.grey[700],
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Tidak', style: TextStyle(color: colorWhite)),
          ),
          new FlatButton(
            color: primaryColor1,
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.clear();
              _onLoading();
            },
            child: new Text('Ya, Keluar', style: TextStyle(color: colorWhite)),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              PreferredSize(
                preferredSize: Size(
                    screenWidth(context), screenHeight(context, dividedBy: 8)),
                child: SafeArea(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: Container(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Profil Vendor",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[200],
                                                  blurRadius: 5.0,
                                                  offset: Offset(
                                                    0,
                                                    1.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                            width: 70,
                                            height: 70,
                                            child: Container(
                                              child: Icon(
                                                Icons.person,
                                                size: 40.0,
                                                color: primaryColor1,
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SelectableText(
                                              Provider.of<User>(context)
                                                  .full_name,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SelectableText(
                                              Provider.of<User>(context).email,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: primaryColor1,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Container(
                                                margin: EdgeInsets.all(2),
                                                child: Center(
                                                  child: Text(
                                                    "VENDOR",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Card(
                        child: ListTile(
                          leading: Icon(
                            CommunityMaterialIcons.key_outline,
                            size: 40,
                            color: primaryColor1,
                          ),
                          title: Text('Ubah Password',
                              style: TextStyle(
                                  color: primaryColor1,
                                  fontWeight: FontWeight.w800)),
                          subtitle: Text('Mengubah Password Akun'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/ubah_password');
                      },
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          CommunityMaterialIcons.book,
                          size: 40,
                          color: primaryColor1,
                        ),
                        title: Text('Tutorial',
                            style: TextStyle(
                                color: primaryColor1,
                                fontWeight: FontWeight.w800)),
                        subtitle: Text('Tata cara penggunaan aplikasi'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () async {
                          _keluar();
                          // pr = new ProgressDialog(
                          //   context,
                          //   type: ProgressDialogType.Normal,
                          // );
                          // pr.show();
                          // var logout = await model.logout();
                          // if (logout) {
                          //   pr.hide();
                          //   _scaffoldKey.currentState.showSnackBar(SnackBar(
                          //       backgroundColor: Colors.green,
                          //       duration: Duration(seconds: 1),
                          //       content: Text("Sukses logout")));
                          //   Timer(
                          //       Duration(
                          //         seconds: 1,
                          //       ), () {
                          //     Navigator.pushNamed(context, 'auth');
                          //   });
                          // } else {
                          //   pr.hide();
                          //   _alertdialog("Gagal logout");
                          // }
                        },
                        child: ListTile(
                          leading: Icon(
                            CommunityMaterialIcons.power,
                            size: 40,
                            color: primaryColor1,
                          ),
                          title: Text('Logout',
                              style: TextStyle(
                                  color: primaryColor1,
                                  fontWeight: FontWeight.w800)),
                          subtitle: Text('Keluar Dari Aplikasi'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
