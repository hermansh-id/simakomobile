import 'package:flutter/material.dart';
import 'package:azad/screen/addData.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:azad/screen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AZAD POS',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = 'https://api.banghasan.com/quran/format/json/surat';
  List data; //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY

  Future<String> getData() async {
    var res = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });

    setState(() {
      var content = json.decode(res.body);
      data = content['hasil'];
    });
    return 'success!';
  }
  @override
  void initState() {
    super.initState();
    this.getData(); //PANGGIL FUNGSI YANG TELAH DIBUAT SEBELUMNYA
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0), //SET MARGIN DARI CONTAINER
        child: ListView.builder( //MEMBUAT LISTVIEW
          itemCount: data == null ? 0:data.length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
          itemBuilder: (BuildContext context, int index) {
            return Container(
                child: Text(data.toString())
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddData()),
          );
        },
        tooltip: 'Tambah Data',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
