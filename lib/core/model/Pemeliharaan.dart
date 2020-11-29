class Pemeliharaan{
  int _id;
  String _pemeliharaan;
  String _jenisPemeliharaan;
  int get id=>_id;
  String get pemeliharaan=>_pemeliharaan;
  String get jenisPemeliharaan=>_jenisPemeliharaan;
  Pemeliharaan.fromMap(Map<String,dynamic>obj){
    _id = int.parse(obj['id']);
    _jenisPemeliharaan  = obj['jenis_pemeliharaan'];
    _pemeliharaan = obj['pemeliharaan'];
  }
}