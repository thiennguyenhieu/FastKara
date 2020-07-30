class UserModel {
  String _user;
  String _pass;

  static final UserModel _instance = UserModel._internal();
  static UserModel getInstance() {
    print('call instance');
    return _instance;
  }

  UserModel._internal();

  String get getUserName => _user;

  void setUserName(String userName) {
    this._user = userName;
  }

  static bool isValidUser(String user) {
    return user != null && user.length > 6;
  }

  static bool isValidPass(String pass) {
    return pass != null && pass.length > 6;
  }
}
