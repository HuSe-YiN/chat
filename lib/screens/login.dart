import 'package:chat/service/auth_service.dart';
import 'package:chat/util/extensions.dart';
import 'package:flutter/material.dart';

import '../mixin/validate_mixin.dart';
import '../provider/global_datas.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with ValidateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_isLogin) {
        await authService.logIn(email: globalDatas.email, password: globalDatas.password);
      } else {
          await authService.signUp(email: globalDatas.email, password: globalDatas.password);
      
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                width: 200,
                child: Image.asset("assets/images/chat.png"),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: ePostaValidator,
                            decoration: const InputDecoration(
                              labelText: "E-Posta",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            onSaved: (value) {
                              globalDatas.email = value!;
                            },
                          ),
                          TextFormField(
                            validator: passwordValidator,
                            decoration: const InputDecoration(
                              labelText: "Şifre",
                            ),
                            obscureText: _isLogin,
                            onSaved: (value) {
                              globalDatas.password = value!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              validator: passwordAgainValidator,
                              decoration: const InputDecoration(
                                labelText: "Şifre tekrar",
                              ),
                              obscureText: _isLogin,
                              onSaved: (newValue) {
                                globalDatas.passwordAgain = newValue!;
                              },
                            ),
                          20.height,
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primaryContainer),
                            child: Text(_isLogin ? "Giriş Yap" : "Kayıt Ol"),
                          ),
                          TextButton(
                              onPressed: () => setState(() {
                                    _isLogin = !_isLogin;
                                  }),
                              child: Text(_isLogin ? "Hesap Oluştur" : "Bir hesabın var mı?")),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
