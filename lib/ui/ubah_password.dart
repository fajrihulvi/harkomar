import 'dart:async';

import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/ubah_password_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:flutter/material.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:provider/provider.dart';
class UbahPassword extends StatefulWidget {
  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  bool _secureText1=true,_secureText2=true,_secureText3 = true;
  TextEditingController 
  oldPassword = new TextEditingController(),
  newPassword = new TextEditingController(),
  confirmPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<UbahPasswordModel>(
      builder:(context,model,child)=>Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
        Size(screenWidth(context), screenHeight(context, dividedBy: 8)),
        child: SafeArea(
            child: Container(
              height: screenHeight(context,dividedBy: 8),
              color: primaryColor1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Text('Ubah Password',style: TextStyle(color: colorWhite,fontSize: 22),),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Form(
          key: _formKey,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              TextFormField(
                controller: this.oldPassword,
                obscureText: _secureText1,
                validator: (val){
                  if(val.isEmpty){
                    return "field kosong";
                  }
                  this.oldPassword.text = val;
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                  icon: Icon(_secureText1 ? Icons.visibility_off : Icons.visibility),
                  onPressed: (){
                    setState(() {
                      this._secureText1 = !this._secureText1;
                    });
                  },
                  ),
                  labelText: "Password Lama",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: disableColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  errorBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: this.newPassword,
                obscureText: _secureText2,
                validator: (val){
                  if(val.isEmpty){
                    return "field kosong";
                  }
                  this.newPassword.text = val;
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                  icon: Icon(_secureText2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: (){
                    setState(() {
                      this._secureText2 = !this._secureText2;
                    });
                  },
                  ),
                  labelText: "Password Baru",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: disableColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  errorBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: this.confirmPassword,
                obscureText: _secureText3,
                validator: (val){
                  if(val.isEmpty){
                    return "field kosong";
                  }
                  if(val.compareTo(this.newPassword.text)!=0){
                     return "konfirmasi password tidak sama";
                  }
                  this.confirmPassword.text = val;
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                  icon: Icon(_secureText3 ? Icons.visibility_off : Icons.visibility),
                  onPressed: (){
                    setState(() {
                      this._secureText3 = !this._secureText3;
                    });
                  },
                  ),
                  labelText: "Konfirmasi Password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: disableColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  errorBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 250,
                height: 50,
                child:RaisedButton(
                  color: primaryColor1,
                  child: Text("Ubah Password",style: TextStyle(color: Colors.white)),
                  onPressed: ()async{
                    if(this._formKey.currentState.validate()){
                      await model.changePassword(Provider.of<User>(context).token, this.newPassword.text, this.oldPassword.text);
                      if(model.result['success']){
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          content: Text("password sukses diubah"), backgroundColor: Colors.green,
                        ));
                        Timer(
                          Duration(seconds: 2),(){
                            Navigator.pop(context);
                          });
                      }
                      else{
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          content: Text(model.result['msg']), backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                )
              )
            ],
          ),
        )
      ),
      ),
     )
    );
  }
}