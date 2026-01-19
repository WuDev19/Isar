import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_demo/Person.dart';

class ListPersonCubit  extends Cubit<List<Person>>{
  ListPersonCubit(super.initialState);

  void sendListPersonQueried(List<Person> list){
    emit(list);
  }
}