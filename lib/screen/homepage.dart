import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
final storage = FlutterSecureStorage();

const SERVER_IP = 'https://simako.kintun.id/api';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = '';
  String result = 'data';

  Future<String> getToken() async {

  }
  Future getData() async{
    var jwt = await storage.read(key: "jwt");
    print(jwt);
      var res = await http.get(
          "$SERVER_IP/sale",
          headers: {
            "Content-Type": 'application/json; charset=utf-8',
            "Accept": "application/json",
            "Authorization": 'Bearer '+jwt
          }
      );
      print(res.request.headers);
      if(res.statusCode == 200) {
        setState(() {
          result = res.body;
        });
      }else {
        setState(() {
          result = res.body;
        });
      }

  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(result),
        ),
      )
    );
  }
}
