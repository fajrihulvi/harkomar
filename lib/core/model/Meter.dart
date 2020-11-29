class Meter {
  int _id;
  String _noSERI;
  String _tipe;
  String _merk;
  int get id=>_id;
  String get noSERI =>_noSERI;
  String get tipe => _tipe;
  String get merk => _merk;

  set tipe(String string){
    this._tipe = string;
  }
  set noSERI(String string){
    this._noSERI = string;
  }
  set merk(String string){
    this._merk = string;
  }
  Meter.initial()
  : _id = 0,
    _noSERI = "",
    _tipe ="",
    _merk ="";
  Meter.fromMap(Map<String,dynamic> obj){
    _id = int.parse(obj['id']);
    _noSERI = obj['no_seri'];
    _tipe = obj['tipe'];
    _merk = obj['merk'];
  }
}