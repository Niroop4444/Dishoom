import 'dart:async';

import 'package:dishoom/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with LoginValidation implements BaseBloc{

  final _emailController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  submit() {
    print("xyx");
  }


  @override
  void dispose() {
    _emailController.close();
  }
}

class LoginValidation {

  var emailValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink){
        (email.contains('@') && email.contains('.com')) ? sink.add(email) : sink.addError('Email is not Valid');
      }
  );


}

