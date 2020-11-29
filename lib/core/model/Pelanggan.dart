class Pelanggan{
  int _id;
  String _idPel;
  int _siteID;
  String _namaPelanggan;
  String _alamat;
  String _tarif;
  String _daya;
  String _lat;
  String _long;
  String _status;
  String _noBA;
  String _nomorWO;
  String _ttdPel;
  String _status_wo;

  int _meterID;
  int _modemID;
  int _simCardID;
  int _woID;
  String _pemeliharaaanID;

  String get pemeliharaanID => _pemeliharaaanID;
  int get id => _id;
  String get idPel => _idPel;
  int get siteID => _siteID;
  String get namaPelanggan => _namaPelanggan;
  String get alamat => _alamat;
  String get ttdpel => _ttdPel;
  String get status => _status;
  String get tarif => _tarif;
  String get daya => _daya;
  String get lat => _lat;
  String get long => _long;
  String get status_wo => _status_wo;
  int get meterID => _meterID;
  int get modemID => _modemID;
  int get simCardID => _simCardID;
  String get noBA => _noBA;
  String get nomorWO=>_nomorWO;
  int get woID => _woID;
  Pelanggan.fromMap(Map<String,dynamic> obj){
    _id = int.parse(obj['id']);
    _idPel = obj['id_pel'];
    _siteID = int.parse(obj['site_id']);
    _namaPelanggan = obj['nama_pelanggan'];
    _alamat=obj['alamat'];
    _ttdPel=obj['ttd_pelanggan'];
    _tarif = obj['tarif'];
    _daya = obj['daya'];
    _lat = obj['lat'];
    _long = obj['long'];
    _status = obj['status'];
    _status_wo = obj['status_wo'];
    _meterID = int.parse( obj['meter_id']);
    _modemID = int.parse( obj['modem_id']);
    _simCardID = int.parse( obj['sim_card_id']);
    _simCardID = int.parse( obj['sim_card_id']);
    _noBA = obj['no_ba'] == null ? "" : obj['no_ba'];
    _nomorWO = obj['nomor'];
    _woID = int.parse(obj['wo_id']);
    _pemeliharaaanID = obj['pemeliharaan_id'];
  }
}