class KodeSegel{
  int _id;
  String _boxAppSblm;
  String _boxAppSsdh;
  String _kwhSblm;
  String _kwhSsdh;
  String _pembatasSblm;
  String _pembatasSsdh;
  int get id=> _id;
  String get boxAppSblm => _boxAppSblm;
  String get boxAppSsdh => _boxAppSsdh;
  String get kwhSblm => _kwhSblm;
  String get kwhSsdh => _kwhSsdh;
  String get pembatasSblm => _pembatasSblm;
  String get pembatasSsdh => _pembatasSsdh;
  set id(int angka){
    this._id = angka;
  }
  set boxAppSblm(String kata){
    this._boxAppSblm = kata;
  }
  set boxAppSsdh(String kata){
    this._boxAppSsdh= kata;
  }
  set kwhSblm(String kata){
    this._kwhSblm=kata;
  }
  set kwhSsdh(String kata){
    this._kwhSsdh = kata;
  }
  set pembatasSblm(String kata){
    this._pembatasSblm = kata;
  }
  set pembatasSsdh(String kata){
    this._pembatasSsdh= kata;
  }
  KodeSegel.initial()
  : _id = 0,
   _boxAppSblm ="",
   _boxAppSsdh ="",
   _kwhSblm ="",
   _kwhSsdh ="",
   _pembatasSblm ="",
   _pembatasSsdh ="";
  KodeSegel.fromMap(Map<String,dynamic> obj){
      _id = int.parse(obj['id']);
    _boxAppSblm = obj['boxapp_sebelum'];
    _boxAppSsdh = obj['boxapp_sesudah'];
    _kwhSblm = obj['kwh_sebelum'];
    _kwhSsdh = obj['kwh_sesudah'];
    _pembatasSblm = obj['pembatas_sebelum'];
    _pembatasSsdh = obj['pembatas_sesudah'];
  }
  
}