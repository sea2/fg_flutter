import 'package:coreui/coreui.dart' as tg;
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:td_client/td_client.dart' as tdClient;
import 'package:td_api/td_api.dart' as td;
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

  int userId=0;

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        NewChatScreenScope.getStringsProvider(context);
    final NewChatViewModel viewModel =
        NewChatScreenScope.getNewChatViewModel(context);

    GetContacts().then((value) {
    value.userIds.forEach((element) {
      setState((){
        userId=element;
      });
    });
    }
    );




    return Column(
      children: <Widget>[
        tg.TextCell(
          onTap: viewModel.onNewGroupTap,
          leading: const Icon(Icons.circle),
          title: stringsProvider.newGroup,
        ),
        tg.TextCell(
          onTap: viewModel.onNewSecretChatTap,
          leading: const Icon(Icons.circle),
          title: stringsProvider.newSecretChat,
        ),
        tg.TextCell(
          onTap: viewModel.onNewChannelTap,
          leading: const Icon(Icons.circle),
          title: stringsProvider.newChannel,
        ),
        // tg.TextCell(
        //   onTap: (){
        //     viewModel.onChatTap(1);
        //   },
        //   leading: const Icon(Icons.circle),
        //   title: stringsProvider.newChannel,
        // ),
        InkWell(child: Text("${userId}", style: TextStyle(color: Colors.red),),
          onTap: () {
            viewModel.onChatTap(userId);
          },)
      ],
    );
  }


    Future<td.Users> GetContacts() =>
        tdClient.ClientSingleton.getClient().send(td.GetContacts());



}
