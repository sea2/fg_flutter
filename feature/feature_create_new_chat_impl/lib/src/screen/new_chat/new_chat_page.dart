import 'dart:async';
import 'dart:convert';

import 'package:coreui/coreui.dart' as tg;
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:td_client/td_client.dart' as tdClient;
import 'package:td_api/td_api.dart' as td;
import 'package:td_client/td_client.dart';

import 'new _contact_add_page.dart';
class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  _Body(),
        floatingActionButton:FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            // tdClient.ClientSingleton.getClient().send<td.User>(td.SearchUserByPhoneNumber(phoneNumber: "8613148111379")).then((value) {
            //  print(jsonEncode(value.toJson()));
            //  tdClient.ClientSingleton.getClient().send<td.User>(td.AddContact(sharePhoneNumber: true,contact:td.Contact(
            //    phoneNumber:"8613148111379",
            //    firstName:"sea",
            //    lastName:"",
            //    vcard:"",
            //    userId:value.id,
            //  )),).then((value) {
            //    print(jsonEncode(value.toJson()));
            //  });
            // });
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (ctx) {
                return NewContactAddPage((firstName,LastName,phone){
                  List< td.Contact> list=[ td.Contact(
                    phoneNumber:phone,
                    firstName:firstName,
                    lastName:LastName,
                    vcard:"",
                    userId:0,
                  )];
                   tdClient.ClientSingleton.getClient().send<td.ImportedContacts>(td.ImportContacts(contacts:list),).then((value) {
                     if(value.userIds.length>0){
                       print("add success ${value.userIds[0]} ");
                       eventBus.fire(AddContactRefresh());
                     }
                   });
                }
                );
              },
            );

          },
        ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
  return _BodyState();
  }

}
class _BodyState extends State<_Body>{

  // {id: 5607272555, first_name: 张哥Eric, last_name: , usernames: null, phone_number: 8613818166160, status: {was_online: 1723454147, @type: userStatusOffline}, profile_photo: null, emoji_status: null, is_contact: true, is_mutual_contact: true, is_verified: false, is_premium: false, is_support: false, restriction_reason: , is_scam: false, is_fake: false, have_access: true, type: {@type: userTypeRegular}, language_code: , added_to_attachment_menu: false, @type: user}
  List<td.User> listUser=[];
  StreamSubscription? eventBusController=null;
  @override
  void initState() {
    super.initState();
    getList();
    eventBusController=  eventBus.on<AddContactRefresh>().listen((event) {
        getList();
  });
  }

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        NewChatScreenScope.getStringsProvider(context);
    final NewChatViewModel viewModel =
        NewChatScreenScope.getNewChatViewModel(context);


List<Widget> mainList=[];
    mainList.add( tg.TextCell(
      onTap: viewModel.onNewGroupTap,
      leading: const Icon(Icons.group),
      title: stringsProvider.newGroup,
    ),);
    mainList.add( tg.TextCell(
      onTap: viewModel.onNewSecretChatTap,
      leading: const Icon(Icons.lock_clock_outlined),
      title: stringsProvider.newSecretChat,
    ), );
    mainList.add(
      tg.TextCell(
        onTap: viewModel.onNewChannelTap,
        leading: const Icon(Icons.speaker),
        title: stringsProvider.newChannel,
      ),);

    listUser.forEach((element) {
      mainList.add( InkWell(child:  getContact(element.id,element.firstName),
        onTap: () {
          viewModel.onChatTap(element.id);
        },onLongPress: (){

        },),);
      mainList.add( Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        color: Color(0xfff5f5f5),height: 1,));
    });

    return SingleChildScrollView(child:Column(
      children: mainList,
    ));
  }


    Future<td.Users> GetContacts() =>
        tdClient.ClientSingleton.getClient().send(td.GetContacts());

  Widget getContact(int userId,String firstName) {
    Color colorBg=
    tg.AvatarWidgetFactory
        .colors[(userId % tg.AvatarWidgetFactory.colors.length).abs()];
String nameFirst="";
if(firstName!=null&&firstName.length>0){
  nameFirst=firstName.substring(0,1);
}
String? imgUrl=null;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
      child: Row(
      children: [
        Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minHeight: 40,
            minWidth: 40,
            maxWidth: 40,
            maxHeight: 40,
          ),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(20.0)),
            color:colorBg,
            image: imgUrl != null
                ? DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            )
                : null,
            // shape: BoxShape.circle,
          ),
          child: Text(nameFirst,style: TextStyle(color: Colors.white,fontSize: 18),),
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(firstName,style: TextStyle(color: Colors.black,fontSize: 14),),

          ],
        )
      ],
    ),);
  }

  void getList() {
    GetContacts().then((value) {
      listUser=[];
      value.userIds.forEach((element) {
        tdClient.ClientSingleton.getClient().send<td.User>(td.GetUser(userId: element)).then((value) {
          listUser.add(value);
        });
      });
      setState((){
      });
    }
    );
  }


  @override
  void dispose() {
    super.dispose();
    eventBusController!.cancel();
  }

}
