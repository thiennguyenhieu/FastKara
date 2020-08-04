class UserModel {
  String _userName;
  String _password;

  static final UserModel _instance = UserModel._internal();
  factory UserModel() {
    return _instance;
  }

  UserModel._internal() {
    _userName = null;
    _password = null;
  }

  String get getUserName => _userName;
  void setUserName(String userName) {
    this._userName = userName;
  }

  String get getPassword => _password;
  void setPassword(String password) {
    this._password = password;
  }

  static bool isValidUser(String userName) {
    return userName != null && userName.length > 6;
  }

  static bool isValidPassword(String password) {
    return password != null && password.length > 6;
  }
}
