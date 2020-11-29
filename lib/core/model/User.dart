class User {
  int id;
  String token;
  String username;
  String no_telp;
  String email;
  String full_name;
  int work_order_id;
  bool isLogin;
  User.initial():
    id = 0,
    token = '',
    username = '',
    no_telp = '',
    email = '',
    work_order_id = 0,
    isLogin = false;
  int get userId => this.id;
  String get _username => this.username;
  String get _token => this.token;
  String get _no_telp => this.no_telp;
  String get _email => this.email;
  String get _fullname => this.full_name;
  int get _work_order_id => this.work_order_id;
  bool get _isLogin => this.isLogin;
  User({this.id,this.token,this.username,this.no_telp,this.full_name,this.email,this.work_order_id});

  User.fromMap(Map<String,dynamic> obj){
    this.id = int.parse(obj['user']['id']);
    this.username = obj['user']['username'];
    this.token = obj['user']['token'];
    this.no_telp = obj['user']['no_telp'];
    this.full_name = obj['user']['nama'];
    this.email = obj['user']['email'];
    this.work_order_id = obj['user']['work_order_id'];
    this.isLogin = obj['user']['token'] == null ? false :true;
    }
  User.fromDB(Map<String,dynamic> obj){
    this.id = obj['id'];
    this.username = obj['username'];
    this.token = obj['token'];
    this.no_telp = obj['no_telp'];
    this.full_name = obj['full_name'];
    this.email = obj['email'];
    this.work_order_id = obj['work_order_id'];
    this.isLogin = obj['token'] == null ? false :true;
    }
    Map<String, dynamic> toMap(){
      var obj = new Map<String, dynamic>();
      obj['id'] = this.id;
      obj['username'] = this.username;
      obj['token'] = this.token;
      obj['no_telp'] = this.no_telp;
      obj['full_name'] = this.full_name;
      obj['email'] =  this.email;
      obj['work_order_id'] = this.work_order_id;
      obj['isLogin'] = this.isLogin;
      return obj;
    }
}
