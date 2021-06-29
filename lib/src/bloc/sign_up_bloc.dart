import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up_flutter/src/bloc/sign_up_event.dart';
import 'package:sign_up_flutter/src/bloc/sign_up_state.dart';
import 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpBloc() : super(InitSignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {

    if(event is LoadingSignUpState){
      yield LoadingSignUpState();
      try{

      } catch(e){

      }
    }
  }

}