import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appId = '38fc42ddad557d9b5d65e4fb1e3fc4ae' ;
  String city='Ha Noi';


  void showInfo() async{
    getWeather(appId, city);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Center(
          child: new Text('Weather App'),
        ),
        backgroundColor: Colors.amber,
      ),
      body:
      new Stack(
        children: <Widget>[
          new Center(
          child: new Image.asset('picture/mb.jpg', width: 400,fit: BoxFit.fill,)
          ),
          new Container(
            alignment: Alignment.topCenter,
            child: Text(
                '\n$city'
            ),
          ),
          new Container(
            alignment: Alignment.center,
          ),
          new Container(
            alignment: Alignment.center,
            child: updateTemp('$city'),
          ),
        ],
      ),
    );

  }

  Future<Map> getWeather(String appId, String city) async {
    String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&units=metric';

    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Widget updateTemp(String city){
    return new FutureBuilder(
      future: getWeather(appId, city),
  builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
      if (snapshot.hasData){
        Map content = snapshot.data;
        return new Container(padding: EdgeInsets.only(top: 30),
          child:  new Column(
            children: <Widget>[

              Image.network('https://openweathermap.org/img/wn/'+content['weather'][0]['icon'].toString()+'@2x.png'),
                 new Text('\n Nhiệt độ:    '+content['main']['temp'].toString()+' °C'),
                new Text('\n Áp suất:    '+content ['main']['pressure'].toString()+' hpa'),
              new Text('\n Độ Ẩm:    '+ content['main']['humidity'].toString()+'%'),

            ],
          )
        );
      }
    });
  }
}
