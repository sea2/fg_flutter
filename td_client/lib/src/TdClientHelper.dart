


import 'package:tdlib/td_client.dart' as tdc;

class ClientSingleton {


  static late tdc.Client _client;

  static  void setClient( tdc.Client client){
    _client=client;
  }

  static  tdc.Client getClient(){
   return _client;
  }


}