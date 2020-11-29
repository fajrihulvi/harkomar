class Arus {
  int _id;
  String _lt;
  String _ls;
  String _lr;
  int _baID;
  int get id=>_id;
  int get baID=>_baID;
  String get lt =>_lt;
  String get ls => _ls;
  String get lr => _lr;
  Arus(int id,String lr,String ls,String lt,int baID){
    this._id = id;
    this._lr = lr;
    this._ls = ls;
    this._baID = baID;
  }
  Arus.initial()
  : _id = 0,
    _baID = 0,
    _lt = "",
    _ls ="",
    _lr ="";
  Arus.fromMap(Map<String,dynamic> obj){
    _id = int.parse(obj['id']);
    _baID = int.parse(obj['hasil_pemeriksaan_id']);
    _lt = obj['nilai_lt'];
    _ls = obj['nilai_ls'];
    _lr = obj['nilai_lr'];
  }
}