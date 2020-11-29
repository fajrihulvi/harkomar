class StandMeter {
  int _id;
  String _lwbp;
  String _wbp;
  String _kvarh;
  int _baID;
  int get id=>_id;
  String get lwbp =>_lwbp;
  String get wbp => _wbp;
  String get kvarh => _kvarh;
  int get baID=>_baID;
  StandMeter.initial()
  : _id = 0,
    _lwbp = "",
    _wbp ="",
    _kvarh ="",
    _baID = 0;
  StandMeter.fromMap(Map<String,dynamic> obj){
    _id = int.parse(obj['id']);
    _lwbp = obj['nilai_lwbp'];
    _wbp = obj['nilai_wbp'];
    _kvarh = obj['nilai_kvarh'];
    _baID = int.parse(obj['hasil_pemeriksaan_id']);
  }
}