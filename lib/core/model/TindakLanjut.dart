class TindakLanjut {
  int _id;
  int _pemeliharaanID;
  int _baID;
  int _meterID;
  int _modemID;
  int _simCardID;
  int _check;
  String _ttdPelanggan;
  String _ttdPetugas;
  String _jenisPemeliharaan;
  String _pemeliharaan;
  int get id => _id;
  int get pemeliharaanID => _pemeliharaanID;
  int get baID => _baID;
  int get meterID => _meterID;
  int get modemID => _modemID;
  int get simCardID => _simCardID;
  String get ttdPelanggan => _ttdPelanggan;
  String get ttdPetugas => _ttdPetugas;
  String get jenisPemeliharaan => _jenisPemeliharaan;
  String get pemeliharaan => _pemeliharaan;
  int get check => _check;
  set id(int angka){
    this._id = angka;
  }
  set pemeliharaanID(int angka){
    this._pemeliharaanID = angka;
  }
  set baID(int angka){
    this._baID = angka;
  }
  set meterID(int angka){
    this._meterID = angka;
  }
  set modemID(int angka){
    this._modemID=angka;
  }
  set simCardID(int angka){
    this._simCardID = angka;
  }
  set check(int angka){
    this._check = angka;
  }
  set ttdPelanggan(String kata){
    this._ttdPelanggan=kata;
  }
  set ttdPetugas(String kata){
    this._ttdPetugas=kata;
  }
  set jenisPemeliharaan(String kata){
    this._jenisPemeliharaan=kata;
  }
  set pemeliharaan(String kata){
    this._pemeliharaan=kata;
  }
  TindakLanjut.initial()
  : _id =0,
    _pemeliharaanID =0,
    _baID =0,
    _meterID =0,
    _modemID =0,
    _simCardID =0,
    _ttdPelanggan = "",
    _ttdPetugas = "",
    _jenisPemeliharaan="",
    _pemeliharaan="";
  TindakLanjut.fromMap(Map<String,dynamic> obj){
    _id = obj['id'] == null ? 0 : int.parse(obj['id']);
    _jenisPemeliharaan = obj['jenis_pemeliharaan'];
    _check = obj['check'] == null ? 0 : int.parse(obj['check']);
    _pemeliharaan = obj['pemeliharaan'];
  }
}