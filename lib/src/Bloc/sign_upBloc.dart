import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:drumsapp/src/Bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class Sign_upBloc with Validatos {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirpasswordController = BehaviorSubject<String>();

  //Recupera los datos del Stream

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPasword);

  Stream<String> get confiremailStream =>
      _confirpasswordController.stream.transform(validarEmail);

  Stream<bool> get formValidStream => Observable.combineLatest3(
      emailStream, passwordStream, confiremailStream, (e, p, c) => true);

  //insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirPassword =>
      _confirpasswordController.sink.add;

//Obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get confirpassword => _confirpasswordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _confirpasswordController?.close();
  }
}
