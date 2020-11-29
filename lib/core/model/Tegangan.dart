class Tegangan {
  int _id;
  String _vt;
  String _vs;
  String _vr;
  int _baID;
  int get id=>_id;
  String get vt =>_vt;
  String get vs => _vs;
  String get vr => _vr;
  int get baID=>_baID;
  Tegangan.initial()
  : _id = 0,
    _vt = "",
    _vs ="",
    _vr ="",
    _baID=0;
  Tegangan.fromMap(Map<String,dynamic> obj){
    _id = int.parse(obj['id']);
    _vt = obj['nilai_vt'];
    _vs = obj['nilai_vs'];
    _vr = obj['nilai_vr'];
    _baID = int.parse(obj['hasil_pemeriksaan_id']);
  }
}