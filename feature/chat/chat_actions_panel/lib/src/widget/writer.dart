import 'dart:async';
import 'dart:io';

import 'package:chat_actions_panel/src/chat_action_panel_scope.dart';
import 'package:chat_actions_panel/src/chat_actions_panel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization_api/localization_api.dart';

import '../panel_state.dart';
import 'chat_action_panel.dart';
import 'package:td_client/td_client.dart';
import 'package:td_client/td_client.dart' as tdClient;
import 'package:td_api/td_api.dart' as td;
class Writer extends StatefulWidget {
  const Writer({
    super.key,
    required this.state,
  });

  final WriterState state;

  @override
  State<Writer> createState() => _WriterState();
}

class _WriterState extends State<Writer> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  late Animation<Size?> _clearIconTween;
  late AnimationController _animationController;
  bool _showSendButton = false;
  StreamSubscription? eventBusController=null;
  int replyMessageId=0;
  String replyName="";
  String replyContent="";
  int chatId=0;
  late ChatActionsPanelViewModel viewModel;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _clearIconTween = SizeTween(begin: Size.zero, end: const Size(1, 1))
        .animate(_animationController);

    _messageController.addListener(_onTextChange);
    super.initState();

    eventBusController=  eventBus.on<ReplyMessageEvent>().listen((event) {
      replyMessageId=event.messageId;
      if(replyMessageId>0){
      tdClient.ClientSingleton.getClient().send<td.Message>(td.GetMessage(chatId:chatId,messageId:replyMessageId,),).then((value) {
        print("引用消息类型${value.content.toString()}");
        if(value.content is td.MessageText){
          td.MessageText contentBean= value.content as td.MessageText;
          replyContent=contentBean.text.text;
        }
        // replyContent=value.content.;
        setState(() {
        });
      });
      }
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChange);
    eventBusController!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel =
        ChatActionPanelScope.getChatActionsPanelViewModel(context);
    final IStringsProvider stringsProvider =
        ChatActionPanelScope.getStringsProvider(context);
    chatId= viewModel.getChatId;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
    Visibility(visible:replyMessageId!=0,child:  Row(
      children: [
        SizedBox(width: 10,),
        Expanded(child:  Text("$replyContent",style: TextStyle(color: Colors.grey),)),
        IconButton(onPressed: (){
          setState(() {
            replyMessageId=0;
          });
        }, icon: Icon(Icons.close,color: Colors.grey,)),
      ],
    )),
      Container(child:  Divider(height: 1),),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          const SizedBox(width: 8),
          Flexible(
            child: TextField(
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: stringsProvider.message,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: _clearIconTween,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: _clearIconTween.value!.height,
                child: child,
              );
            },
            child: SizedBox(
              height: kPanelHeight,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  viewModel.onSendMessage(text: _messageController.text,replyToMessageId: replyMessageId);
                  _messageController.text = '';
                  setState(() {
                    replyMessageId=0;
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 8),

          Visibility(visible:!_showSendButton,child: IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () {
              takePhotos();
            },
          ), ),
        ],
      )
    ],);
  }

  final picker = ImagePicker();
  //调用相机
  void takePhotos() async {
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    String imagePath = pickedFile?.path ?? "";
if(imagePath!=null&&imagePath.isNotEmpty) {
  viewModel.sendImage(imagePath, replyMessageId);
  _messageController.text = '';
  setState(() {
    replyMessageId = 0;
  });
}
  }




  void _onTextChange() {
    setState(() {
      final bool _prevValue = _showSendButton;
      _showSendButton = _messageController.text.isNotEmpty;
      if (_showSendButton != _prevValue) {
        if (_showSendButton) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    });
  }
}
