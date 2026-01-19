import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_demo/Address.dart';
import 'package:isar_demo/GetDataCubit.dart';
import 'package:isar_demo/ListPersonCubit.dart';
import 'package:isar_demo/Person.dart';
import 'package:isar_demo/RadioCubit.dart';

import 'Status.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final idController = TextEditingController();
  final tenController = TextEditingController();
  final xaController = TextEditingController();
  final huyenController = TextEditingController();
  final ageController = TextEditingController();
  late final Isar isar;
  late int _selected;

  @override
  void initState() {
    super.initState();
    isar = isarGlobal;
  }

  @override
  Widget build(BuildContext context) {
    print("build lại");
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RadioCubit(1)),
        BlocProvider(create: (context) => GetDataCubit(null)),
        BlocProvider(create: (context) => ListPersonCubit([])),
      ],
      child: Builder(
        builder: (context) {
          // phải là context nằm dưới provider thì mới context.read() hoặc context.watch() được
          return SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Nhập id: "),
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: TextField(
                          controller: idController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Nhập tên: "),
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: TextField(
                          controller: tenController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Nhập xã: "),
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: TextField(
                          keyboardType: TextInputType.streetAddress,
                          controller: xaController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Nhập huyện: "),
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: TextField(
                          keyboardType: TextInputType.streetAddress,
                          controller: huyenController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Nhập tuổi: "),
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: ageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<RadioCubit, int>(
                    builder: (BuildContext context, state) {
                      _selected = state;
                      return RadioGroup(
                        onChanged: (value) {
                          context.read<RadioCubit>().switchRadio(
                            int.parse(value.toString()),
                          );
                        },
                        groupValue: state,
                        child: Column(
                          children: [
                            RadioListTile(
                              value: 0,
                              title: Text("Died"),
                              activeColor: Colors.teal,
                            ),
                            RadioListTile(
                              value: 1,
                              title: Text("Alive"),
                              activeColor: Colors.teal,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 100,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        // childAspectRatio: 2 //tỉ lệ width / height
                        mainAxisExtent: 40,
                      ),
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // ReceivePort rp = ReceivePort();
                            // var tmp = await Isolate.spawn(computeHard, [
                            //   1000000000,
                            //   rp.sendPort,
                            // ]);
                            // rp.listen(
                            //   (message) {
                            //     print(message);
                            //   },
                            //   onError: (e) {
                            //     tmp.kill(priority: Isolate.immediate);
                            //   },
                            // );
                            Address address = Address();
                            address.xa = xaController.text.trim();
                            address.huyen = huyenController.text.trim();
                            Person person = Person();
                            person.name = tenController.text.trim();
                            person.address = address;
                            person.age = int.parse(ageController.text.trim());
                            person.status = _selected == 1
                                ? Status.alive
                                : Status.died;
                            await isar.writeTxn(() async {
                              await isar.persons.put(person);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                          child: Text(
                            "Create",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final person = await isar.persons.get(
                              int.parse(idController.text.trim()),
                            );
                            if (person != null) {
                              if (tenController.text.isNotEmpty) {
                                person.name = tenController.text.trim();
                              }
                              if (ageController.text.isNotEmpty) {
                                person.age = int.parse(
                                  ageController.text.trim(),
                                );
                              }
                              if (xaController.text.isNotEmpty) {
                                person.address.xa = xaController.text.trim();
                              }
                              if (huyenController.text.isNotEmpty) {
                                person.address.huyen = huyenController.text
                                    .trim();
                              }
                              person.status = _selected == 1
                                  ? Status.alive
                                  : Status.died;
                              await isar.writeTxn(() async {
                                await isar.persons.put(person);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await isar.writeTxn(() async {
                              await isar.persons.delete(
                                int.parse(idController.text.trim()),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                          ),
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final list = await isar.persons.count();
                            print(list);
                            final person = await isar.persons.get(
                              int.parse(idController.text.trim()),
                            );
                            context.read<GetDataCubit>().sendPerson(person);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          child: Text(
                            "Get",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final listPerson = await isar.persons.filter().anyOf(
                        [10, 111, 19],
                        (q, element) {
                          return q.ageEqualTo(element);
                        },
                      ).findAll();
                      context.read<ListPersonCubit>().sendListPersonQueried(
                        listPerson,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: Text("Fetch", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<GetDataCubit, Person?>(
                    builder: (BuildContext context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(state?.name ?? "null"),
                          Text(state?.age.toString() ?? "null"),
                          Text(state?.address.xa ?? "null"),
                          Text(state?.address.huyen ?? "null"),
                          Text(state?.status.name ?? "null"),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 500,
                    child: BlocBuilder<ListPersonCubit, List<Person>>(
                      builder: (BuildContext context, List<Person> state) {
                        return  ListView.builder(
                          itemBuilder: (context, index) {
                            final ps = state.elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  color: Colors.blueGrey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        ps.id.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ps.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ps.age.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: state.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //test isolate sử dụng spawn, phải đặt static nếu để trong file 1 class hoặc để ngoài file class cũng được
  static Future computeHard(List<dynamic> list) async {
    final first = list[0];
    final sendPort = list[1] as SendPort;
    int sum = 0;
    for (int i = 0; i < first; i++) {
      sum += i;
    }
    sendPort.send(sum);
  }
}
