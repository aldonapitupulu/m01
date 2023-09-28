import 'package:flutter/material.dart';
import 'package:m01/stream.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _data = [];
  String desc = "";
  Future<List<String>> getUserData() async {
    _data = ["Bunny", "Funny", "Miles"];
    await Future.delayed(const Duration(seconds: 3), () {
      print("Downloaded ${_data.length} data");
    });
    return _data;
  }

  List<Map> _userData = [];
  Future<List<Map>> getUserInfo() async {
    _userData = [
      {"name": "Aldo", "NoHp": "0812121212"},
      {"name": "suba", "NoHp": "0813131313"},
    ];
    await Future.delayed(const Duration(seconds: 4), () {
      desc = "Downloaded ${_userData.length} data from userData..";
    });
    return _userData;
  }

  void getData() async {
    var result = await getUserData();
    setState(() {
      _data = result;
    });
  }

  void getUserInfoData() async {
    var res = await getUserInfo();
    setState(() {
      desc = "Downloaded ${_userData.length} data from userData..";
      _userData = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Demo Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text('Set User')),
            ElevatedButton(
                onPressed: () {
                  getUserInfoData();
                  print(desc);
                },
                child: Text("Latihan")),
            _userData.isEmpty ? Text(desc) : Container(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const contoh2()));
                },
                child: Text("Stream")),
            Text("Daftar Pengguna"),
            Text(
              '$_data',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            _userData.isEmpty
                ? Container()
                : Expanded(
                    child: ListView.builder(
                        itemCount: _userData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Text(
                                "${_userData[index]["name"]} ${_userData[index]["NoHp"]}",
                                textAlign: TextAlign.center),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
