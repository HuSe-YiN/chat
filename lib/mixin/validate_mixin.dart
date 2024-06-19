import 'package:chat/provider/global_datas.dart';

mixin ValidateMixin {
  String? ePostaValidator(String? value) {
    if (value == null) {
      return null;
    }
    return (value.isNotEmpty && value.contains("@")) ? null : "Lütfen geçerli bir e-posta adresi giriniz";
  }

  String? passwordValidator(String? value) {
    if (value == null) {
      return null;
    }
    if (value.length < 6) {
      return "Şifre minimum 6 karakter içermelidir";
    } else if (value.length > 20) {
      return "Şifre maksimum 20 karakter içermelidir";
    }
    globalDatas.password = value;
    return null;
  }

  String? passwordAgainValidator(String? value) {
    if (value == null) {
      return null;
    }
    return (value == globalDatas.password) ? null : "Şifreler aynı değildir";
  }
}
