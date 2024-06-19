class GlobalDatas {
  static GlobalDatas instance = GlobalDatas._internal();
  factory GlobalDatas() {
    return instance;
  }

  GlobalDatas._internal() {
    email = "";
    password = "";
    passwordAgain = "";
  }

  late String email;
  late String password;
  late String passwordAgain;
}

GlobalDatas globalDatas = GlobalDatas();