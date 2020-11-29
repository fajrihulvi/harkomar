class Berita_Acara {
  int _id;
  String _nomorBA;
  int _pelangganID;
  String _noPelanggan;
  String _namaPelanggan;
  String _alamat;
  String _tarif;
  String _lat;
  String _long;
  String _status;

  int get id => _id;
  String get nomorBA => _nomorBA;
  int get pelangganID => _pelangganID;
  String get noPelanggan => _noPelanggan;
  String get namaPelanggan => _namaPelanggan;
  String get alamat => _alamat;
  String get tarif => _tarif;
  String get lat =>_lat;
  String get long => _long;
  String get status => _status;

  Berita_Acara.fromWorkOrder(Map<String,dynamic> obj){
    _id = int.parse(obj['id']);
    _nomorBA = obj['nomor'];
    _pelangganID = int.parse(obj['pelanggan_id']);
    _noPelanggan = obj['id_pel'];
    _namaPelanggan = obj['nama_pelanggan'];
    _alamat = obj['alamat'];
    _tarif = obj['tarif'];
    _status = obj['status_wo'];
    _lat = obj['lat'] == null ? "" : obj['lat'];
    _long = obj['long'] == null ? "" : obj['long'];
  }
}