class WorkOrder{
  int _id;
  String _nomorWO;
  String _tanggal;
  String _jenisPemeliharaan;    
  String _pemeliharaan;

  int get id => _id;
  String get nomorWO => _nomorWO;
  String get tanggal=>_tanggal;
  String get jenisPemeliharaan => _jenisPemeliharaan;
  String get pemeliharaan => _pemeliharaan;

  set nomorWO(String kata){
    this._nomorWO = kata;
  }

  set id(int angka){
    this._id = angka;
  }

  WorkOrder.fromMap(Map<String,dynamic>obj){
    _id = int.parse(obj['id']);
    _nomorWO = obj['nomor_work_order'];
    _tanggal = obj['tanggal_work_order'];
    _jenisPemeliharaan = obj['jenis_pemeliharaan'];
    _pemeliharaan = obj['pemeliharaan'];
  }
  WorkOrder.fromMapList(Map<String,dynamic>obj) 
  : _id = obj['id'],
    _nomorWO = obj['nomor_work_order'],
    _tanggal = obj['tanggal_work_order'],
    _jenisPemeliharaan = obj['jenis_pemeliharaan'],
   _pemeliharaan = obj['pemeliharaan'];
   
}