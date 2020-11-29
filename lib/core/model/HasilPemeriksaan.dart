class HasilPemeriksaan {
  int _id;
  int _pemeliharaanID;
  int _baID;
  int _check;
  String _ttdPelanggan;
  String _ttdPetugas;
  String _jenisPemeliharaan;
  String _pemeliharaan;
  int get id => _id;
  int get pemeliharaanID => _pemeliharaanID;
  int get baID => _baID;
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
  HasilPemeriksaan.initial()
  : _id =0,
    _pemeliharaanID =0,
    _baID =0,
    _ttdPelanggan = "",
    _ttdPetugas = "",
    _jenisPemeliharaan="",
    _check = 0,
    _pemeliharaan="";
  HasilPemeriksaan.fromMap(Map<String,dynamic> obj){
    _id = obj['id'] == null ? 0 : int.parse(obj['id']);
    _check = obj['check'] == null ? 0 : int.parse(obj['check']);
    _jenisPemeliharaan = obj['jenis_pemeliharaan'];
    _pemeliharaan = obj['pemeliharaan'];
  }
}