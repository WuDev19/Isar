import 'package:isar_community/isar.dart';
import 'package:isar_demo/Address.dart';
import 'package:isar_demo/Status.dart';

part 'Person.g.dart';

//@embedded: nhúng class vào trong cùng bảng hiện tại, ko tạo bảng mới
@collection
class Person {
  Id id = Isar.autoIncrement; // ko cần truyền vào constructor
  @Index()
  late String name;
  late Address address;
  @Index()
  late int age;
  @enumerated // khi dùng enum thì dùng cái này
  late Status status;

}
