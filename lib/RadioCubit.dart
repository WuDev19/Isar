import 'package:flutter_bloc/flutter_bloc.dart';

class RadioCubit extends Cubit<int>{
  RadioCubit(super.initialState);

  void switchRadio(int value){
    emit(value);
  }

}