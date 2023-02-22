import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_lessons/person_model.dart';
import 'package:hive_lessons/univer_data.dart';
import 'package:hive_lessons/view_univers.dart';
import 'package:http/http.dart' as http;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(UniverAdapter());
  Hive.registerAdapter(UniverResponseAdapter());
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Box? box;
  final name = TextEditingController();
UniverResponse? data;


  void _incrementCounter(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Name"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: name,
                ),

              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                   var res = await http.get(Uri.parse("http://universities.hipolabs.com/search?country=${name.text}"));
                   data = UniverResponse.fromJson(
                     jsonDecode(res.body), name.text
                   );
                   box!.put(name.text,data ?? UniverResponse(univers: [], name: name.text));
                    setState(() {});

                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  hiveInit() async {
    box = await Hive.openBox('country');
  }

  @override
  void initState() {
    hiveInit();
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: box?.values.length??0 ,
          itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewUniversPage(data: box?.values.elementAt(index))));
            },
            child: Container(
              color: Colors.lightBlue,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(box?.values.elementAt(index).name ?? ""),
                    ]
                  ),
                  IconButton(onPressed: (){
                    box!.deleteAt(index);
                    setState(() {

                    });
                  }, icon: const Icon(Icons.delete))
                ],
              ),
            ),
          );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          _incrementCounter(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


