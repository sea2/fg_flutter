import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_api.dart';
import 'package:tdlib/td_client.dart' as tdc;


export 'package:tdlib/td_client.dart' show TdFunctionException;

class TdClient {
  late tdc.Client _client;

  final PublishSubject<td.TdObject> _eventController =
      PublishSubject<td.TdObject>();

  Future<void> init() async {
    _client = tdc.Client.create();
    _client.updates.listen((td.TdObject? event) {
      if (event != null) {
        _eventController.add(event);
        print("--通知---"+event.toString());
        if(event is UpdateNewMessage){
          eventBus.fire(MyEvent('Hello EventBus!'));
        }
      }
    });
    await _client.initialize();
    ClientSingleton.setClient(_client);
  }

  Stream<td.TdObject> get events => _eventController.stream;

  Future<T> send<T extends td.TdObject>(td.TdFunction object) async =>
      _client.send(object);

  T execute<T extends td.TdObject>(td.TdFunction object) =>
      _client.execute(object);
}



EventBus eventBus = EventBus();
class MyEvent {
  String message;
  MyEvent(this.message);
}
class AddContactRefresh {
}
class ReplyMessageEvent {
  int messageId;
  ReplyMessageEvent(this.messageId);
}



