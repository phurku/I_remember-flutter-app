import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'home.dart';

class AddItem1 extends StatefulWidget {
  final Function onSave ;
 const AddItem1({Key key, this.onSave}) : super(key: key);

  @override
  _AddItem1State createState() => _AddItem1State();
}

class _AddItem1State extends State<AddItem1> {
    String title;
    String description;
    File _image;
  //File galleryimage;
    _showOptionsDialog () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 180,
            child: Column(
              children: <Widget>[
                Container(color: Colors.greenAccent,
                  child: ListTile(title: Text("Select image"),),
                ),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text("Pick from Gallery"),
                  onTap: (){
                     _getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a picture"),
                  onTap: (){
                    _getImage(ImageSource.camera);
                    Navigator.pop(context);
                  } 
                ),
              ],
            ),
            
          ),
        );
      }
    );
  }

 Future _getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source:source);
    if(image != null) {
      setState(() {
        _image = image;
      });
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text("Add item"),
        )
      ),
      body:
       ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          TextField(
            decoration:InputDecoration(
              hintText: 'item name'
            ),
            onChanged: (value){
              setState(() {
               title =value ; 
              });
            },
          ),
           
            SizedBox(height: 20,),
           TextField(
             decoration:InputDecoration(
               hintText: 'description'
             ),
             onChanged: (value){
               setState(() {
                description=value ;  
               });
             },
             maxLines: 4,
           
          ),
          SizedBox(height: 20,),

          SizedBox(height: 50,
          width: 20.0,
          child: 
          RaisedButton.icon(
            icon: Icon(Icons.camera),
            label: Text("Add Image"),
            color: Colors.redAccent,
            onPressed:()=>_showOptionsDialog(),
              )  
                ,),
          SizedBox(height: 20,),
         
          SizedBox(
            
          child: _image == null ? Container() : Image.file(_image,height: 200,),),
          SizedBox(height: 20,),
          // SizedBox(height: 50,
          // width: 20.0,
          // child: 
          // RaisedButton.icon(
          //       icon: Icon(Icons.photo_album),
          //       label: new Text('Add Image From Gallery'),
          //       color: Colors.blue,
          //       onPressed:galleryPicker,
          //   ),
          // ),
         // SizedBox(height: 20,),
          //displayFile(galleryimage),
        //  SizedBox(height: 20,),
          SizedBox(height: 50,
          width: 30.0,
          child: 
          RaisedButton.icon(
            icon: Icon(Icons.save),
            label: Text("Save item"),
            color: Colors.blue,
            onPressed: (){
              
               widget.onSave(title,description,_image);
               Navigator.push(context, MaterialPageRoute(
                 builder: (_)=>HomePage()
               ));
            },
          ),
          )
        ],
      ),
    );
  }
}
  //  Widget displayFile(File file) {
  //   return new SizedBox(
  //     child: file == null
  //         ? null
  //         : new Image.file(file),
  //   );
  // }