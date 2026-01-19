import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_demo/Person.dart';

class GetDataCubit extends Cubit<Person?>{
  GetDataCubit(super.initialState);

  void sendPerson(Person? p){
    emit(p);
  }

}