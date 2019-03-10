import 'package:flutter/material.dart';
import 'home.dart';
//import 'dart:io';
class ItemDetails extends StatelessWidget {
  final Function delete;
  final Map item;
  //const ItemDetails({Key key,this.item,this.delete}):super(key:key);
  const ItemDetails({Key key, this.item,this.delete}) : super(key: key);



 showDialogBox(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context){
 return AlertDialog(
  title: Text('Are you sure to delete?'),
  actions: <Widget>[
    FlatButton(
      child: Text('ok'),
      onPressed: (){delete(item);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomePage()));

       }, ),
       FlatButton(
         child: Text('cancel'),
         onPressed: ()=>Navigator.pop(context),
       )
  ],
);
    }
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(item["title"]),
        actions: <Widget>[
          
          IconButton(icon: Icon(Icons.delete),
          onPressed: (){
            showDialogBox(context);
          },)
        ], 
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              child: Container(
                height: 150,
                width: 150,
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  item["img"],
                ),
              )),
            ),
            Text(
              item["title"],
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(item["description"]),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}