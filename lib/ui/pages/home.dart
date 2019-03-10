import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './additem.dart';
import './itemdetail.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items;

  void initState(){
    super.initState();
    getItems();
  }
  getItems()async{
    final sp=await SharedPreferences.getInstance();
    var itemString=sp.getString('items');
    if(itemString==null){
      print('No any item.');
     setState((){
       items=[];
     });
      await saveItem(items);
    }
    else{
      setState(() {
       items=json.decode(itemString);

      });
  }}
  saveItem(items)async{
    final sp=await SharedPreferences.getInstance();
    await sp.setString('items',json.encode(items));
    print('saved');
    print(items);
  }
 addItem1(String title, String description, File image) {
    setState(() {
      items.add({
        "title": title,
        "description": description,
        "img": image.path,
      });
      saveItem(items);
    });
  }
  removeItem1(Map item){
    setState(() {
     items.remove(item); 
    });
    saveItem(items);
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     //   leading: IconButton(icon: Icon(
       //   Icons.menu
        
       // onPressed: (){},),
        title: Text("List of your item"),
      /*  actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],*/
        backgroundColor: Colors.redAccent,
  
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(
          builder: (_)=>AddItem1(onSave:addItem1)
        )),
      
      ),
    );
      }
       Widget _buildBody(){
       return ListView.builder(
         itemCount: items.length,
         itemBuilder: (BuildContext context,int index){
             var item=items[index];
                return ListTile(
                  
                  onTap: ()=>Navigator.push(context,MaterialPageRoute(
                    builder: (_)=>ItemDetails(item:item)
                  )),
                 // isThreeLine: true,
                  title: Text(item['title']),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(item['img']),),
                    radius:35,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: ()=>_delete(item),
                  ),
                  subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item['description']),SizedBox(height: 40,),
                    ],
                  ) ,
                );
              },
            );
          
     }
void  _delete(Map item){
   showDialog(
     context:context,builder:(BuildContext context){
       return AlertDialog(
         //title: Text('delete'),
         content: Text('Are u sure to delete??'),
         actions: <Widget>[
           FlatButton(
             child: Text('yes'),
             onPressed: (){
               removeItem1(item);
               Navigator.pop(context);
             },
           ),
           FlatButton(
             child: Text('no'),
             onPressed: ()=>Navigator.pop(context),
           )
         ],
       );
     }
   );
}
}  
     
    
        
         /* SizedBox(height: 20.0,),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context,int index){
                var item=items[index];
                return ListTile(
                  onTap: ()=>Navigator.push(context,MaterialPageRoute(
                    builder: (_)=>ItemDetails(item:item)
                  )),
                  isThreeLine: true,
                  title: Text(item['title']),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(item['img']),),
                    radius:35,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: ()=>_delete(item),
                  ),
                  subtitle:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item['description']),SizedBox(height: 40,),
                    ],
                  ) ,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.push(
          context,MaterialPageRoute(
            builder: (_)=>AddItem1(addItem1)
        ),
      ),
      tooltip: 'Add Item',
      child: Icon(Icons.add),),
      backgroundColor: Colors.blueGrey,
    );
  }*/