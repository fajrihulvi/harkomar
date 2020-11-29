class SimCard {
  int _id;
  String _noSIM;
  String _brand;
  int get id=>_id;
  String get noSIM =>_noSIM;
  String get brand => _brand;
  set noSIM(String string){
    this._noSIM = string;
  }
  set brand(String string){
    this._brand = string;
  }
  SimCard.initial()
  : _id = 0,
    _noSIM = "",
    _brand ="";
  SimCard.fromMap(Map<String,dynamic> obj){
    _id = int.parse(obj['id']);
    _noSIM = obj['no_sim'];
    _brand = obj['brand'];
  }
}