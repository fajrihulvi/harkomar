import 'package:flutter/material.dart';

class FormKodeSegel extends StatelessWidget {
  final Function onChange;
  final TextEditingController boxAppSblm,boxAppSsdh,kwhSblm,kwhSsdh,pembatasSblm,pembatasSsdh;
  final bool enableEdit;
  const FormKodeSegel({this.onChange, this.boxAppSblm, this.boxAppSsdh, this.kwhSblm, this.kwhSsdh, this.pembatasSblm, this.pembatasSsdh,this.enableEdit=true});
  
  @override
  Widget build(BuildContext context) {
    return Card(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Box App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        TextFormField(
                          enabled: this.enableEdit,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sebelum Pemeriksan',
                          ),
                          controller: this.boxAppSblm,
                          onChanged: this.onChange
                        ),
                        TextFormField(
                          enabled: this.enableEdit,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sesudah Pemeriksan',
                          ),
                          controller: this.boxAppSsdh,
                          onChanged: this.onChange,
                        ),
                        SizedBox(height: 20,),
                        Text('KWH Meter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        TextFormField(
                          enabled: this.enableEdit,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sebelum Pemeriksan',
                          ),
                          controller: this.kwhSblm,
                          onChanged: this.onChange,
                        ),
                        TextFormField(
                          enabled: this.enableEdit,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sesudah Pemeriksan',
                          ),
                          controller: this.kwhSsdh,
                          onChanged: this.onChange,
                        ),
                        SizedBox(height: 20,),
                        Text('Pembatas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        TextFormField(
                          enabled: this.enableEdit,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sebelum Pemeriksan',
                          ),
                          controller: this.pembatasSblm,
                          onChanged: this.onChange,
                        ),
                        TextFormField(
                          enabled: this.enableEdit,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sesudah Pemeriksan',
                          ),
                          controller: this.pembatasSsdh,
                          onChanged: this.onChange,
                        )

                      ],
                    ),
                  ),);
  }
}