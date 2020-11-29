import 'package:amr_apps/core/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {

  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({this.builder,this.onModelReady});

  @override
  _BaseviewState<T> createState() => _BaseviewState();
}

class _BaseviewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();
  @override
  void initState(){
    if(widget.onModelReady != null){
      widget.onModelReady(model);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        builder: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}