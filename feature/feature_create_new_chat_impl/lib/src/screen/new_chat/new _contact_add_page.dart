


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewContactAddPage extends StatefulWidget{

   Function(String f,String l,String p) callBack;
   NewContactAddPage(this.callBack,{super.key});

  @override
  State<StatefulWidget> createState() {
  return NewContactAddPageState();
  }

}



class NewContactAddPageState extends State<NewContactAddPage>{


  FocusNode _focusNodeFirst = FocusNode();
  FocusNode _focusNodeLast = FocusNode();
  TextEditingController _editingControllerFirst = new TextEditingController();
  TextEditingController _editingControllerLast = new TextEditingController();
  TextEditingController _editingControllerCode = new TextEditingController();
  TextEditingController _editingControllerPhone= new TextEditingController();
String remarkError="";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(_focusNodeFirst); // 自动聚焦
    });
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.transparent,
         resizeToAvoidBottomInset: true,
         body:Container(
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
              padding: EdgeInsets.only(top: 20,left: 20,right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New Contact",style: TextStyle(color: Colors.black,fontSize: 20),),
                  TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    focusNode: _focusNodeFirst,
                    controller: _editingControllerFirst,
                    autofocus: true,
                    // textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "First name",
                      hintStyle: TextStyle(color: Colors.black26),
                      // prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      // 未获得焦点下划线设为灰色
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      //获得焦点下划线设为蓝色
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2196f3)),
                      ),
                    ),
                    onSubmitted: (val) {},
                    onTap: () {},
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    focusNode: _focusNodeLast,
                    controller: _editingControllerLast,
                    autofocus: false,
                    // textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Last name(optional)",
                      hintStyle: TextStyle(color: Colors.black26),
                      // prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      // 未获得焦点下划线设为灰色
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      //获得焦点下划线设为蓝色
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2196f3)),
                      ),
                    ),
                    onSubmitted: (val) {},
                    onTap: () {},
                  ),
                  Row(
                    children: [

                     Container(child: Stack(
                       children: [
                         TextField(
                           keyboardType: TextInputType.number,
                           inputFormatters: [
                             FilteringTextInputFormatter(
                                 RegExp("^[a-z0-9A-Z]+"),
                                 allow: true)
                           ],
                           style: TextStyle(
                             fontSize: 20,
                             color: Colors.black,
                           ),
                           textAlignVertical: TextAlignVertical.center,
                           controller: _editingControllerCode,
                           autofocus: false,
                           // textInputAction: TextInputAction.search,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(left: 30,bottom: 10,top: 10),
                             hintText: "",
                             hintStyle: TextStyle(color: Colors.black26),
                             // prefixIcon: Icon(Icons.search),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(5)),
                             ),
                             // 未获得焦点下划线设为灰色
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.black26),
                             ),
                             //获得焦点下划线设为蓝色
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Color(0xff2196f3)),
                             ),
                           ),
                           onSubmitted: (val) {},
                           onTap: () {},
                         ),
                      Container(child:    Icon(Icons.add,color: Colors.black,size: 18,),margin: EdgeInsets.only(top: 20),)
                       ],
                     ),width: 80,),
                      Container(color: Color(0xff999999),width: 1,height: 20,),
                      Expanded(child:  TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter(
                              RegExp("^[a-z0-9A-Z]+"),
                              allow: true)
                        ],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        controller: _editingControllerPhone,
                        autofocus: false,
                        // textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20,bottom: 10,top: 10),
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.black26),
                          // prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          // 未获得焦点下划线设为灰色
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          //获得焦点下划线设为蓝色
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff2196f3)),
                          ),
                        ),
                        onSubmitted: (val) {},
                        onTap: () {},
                      ),)
                    ],
                  ),
                 SizedBox(height: 20,),
                 Text(remarkError,style: TextStyle(color: Colors.red,fontSize: 14),),
                 InkWell(child:  Container(
                   width: double.infinity,
                   alignment: Alignment.center,
                   margin: EdgeInsets.symmetric(vertical: 15,horizontal: 0),
                   padding: EdgeInsets.symmetric(vertical: 10),
                   decoration: BoxDecoration(
                     color:  Color(0xff2196f3),
                     borderRadius: BorderRadius.all( Radius.circular(8)),
                   ),
                   child: Text("Create Contact",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,height: 1),),
                 ),onTap: (){

                   String firstName= _editingControllerFirst.text;
                   String lastName=  _editingControllerLast .text;
                   String code=  _editingControllerCode .text;
                   String phone=  _editingControllerPhone.text;

                   if(firstName==null||firstName.isEmpty){
                     setState(() {
                       remarkError="First name cannot be empty";
                     });
                     return;
                   }else                   if(code==null||code.isEmpty){
                     setState(() {
                       remarkError="Incomplete phone number";
                     });
                     return;
                   }else if(phone==null||phone.isEmpty){
                     setState(() {
                       remarkError="Incomplete phone number";
                     });
                     return;
                   }

                   Navigator.of(context).pop();
                   widget.callBack(firstName,lastName,"+$code$phone");
                 },)
                ],
              ))
        ],
      ) ,));

  }

}