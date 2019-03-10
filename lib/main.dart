import 'package:flutter/material.dart';
import 'ui/pages/home.dart';
void main()=>runApp(MyApp()); 
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Main',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        "builder":(_)=>HomePage(),
        
      } ,
    );
  }
}