import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_demo/HomePage.dart';
import 'package:isar_demo/Person.dart';
import 'package:path_provider/path_provider.dart';

//Dùng bản community mới run được app
late Isar isarGlobal;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //đảm bảo đã bind giao diện xong
  final dir =
      await getApplicationDocumentsDirectory(); //lấy đường dẫn thư mục ứng dụng, mỗi app khi cài đặt sẽ có 1 directory riêng
  isarGlobal = await Isar.open(
    [PersonSchema],
    directory: dir.path,
  ); //khởi tạo biến toàn cục isar để sử dụng ở các screen khác
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo Isar"),
          backgroundColor: Colors.lightGreen,
        ),
        body: const HomePage(),
      ),
    );
  }
}
