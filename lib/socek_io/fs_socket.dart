import 'package:flutter/services.dart';

//import 'package:web_socket_channel/io.dart';
//
//import 'package:socket_io_client/socket_io_client.dart' as IO;
//import 'package:centrifuge/centrifuge.dart' as centrifuge;
class FsSocket {
//  static SocketIO socketIO;
//  static SocketIO socket;

  static connectSocket01() {
//    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
//      if (unit != null) {
//        String socId = unit["soc_id"];
//        AppUtils.getDeviceDetails().then((deviceDetails) {
//          String deviceKey = deviceDetails[2];
//          print("socid ----------------------------------------------- $socId");
//          String query = "company_id=" + socId + "&device_id=" + deviceKey;
//
//          SocketIOManager manager = SocketIOManager();
//
//          HashMap<String, String> hm = new HashMap();
//          hm["company_id"] = socId;
//          hm["device_id"] = deviceKey;
//          var a = {"company_id": socId, "device_id": deviceKey};
//          SocketOptions option = SocketOptions(
//              "http://stgrealtime.vizitorlog.com",
//              /*?company_id=" + socId +
//                  "&device_key=" + deviceKey,*/
//              query: hm,
//              transports: [Transports.POLLING],
//              enableLogging: true);
////          option.timeout = 3000;
//
//          print(option.uri);
//
//          try {
//            manager.createInstance(option).then((sockt) {
//              socket = sockt;
//              socket.isConnected().then((isconeedte) {
//                print("isconected------------------------");
//                print(isconeedte);
//              });
//              print(
//                  "---------------------------connection--------------------------------------------------------");
//              socket.onConnect((data) {
//                print("connected...");
//                print(data);
//
////                socket.emit("message", ["Hello world!"]);
//              });
//              sockt.onPing(onListen);
//              sockt.onPong(onListen);
//              sockt.onConnecting(onListen);
//
////              sockt.onConnecting(onListen);
//              sockt.onError(onListen);
//
//              sockt.onReconnectError(onListen);
//              sockt.onConnectTimeout(onListen);
//              sockt.onConnectError(onListen);
//              sockt.onConnect(onListen);
//              sockt.on("member_approval", onListen);
////              socket.onReconnect(onListen);
////              socket.onReconnectError(onListen);
////              socket.onReconnectFailed(onListen);
////              socket.on("connect", (data) {
////                //sample event
////                print("connect");
////                print(data);
////              });
//
//              socket.on("ask_member_approval", handleEvent);
//              socket.connect();
//            }); //TODO change the port  accordingly
//          } catch (e) {
//            print("exception-----------------------");
//            print(e);
//          }
//        });
//      }
//    });
  }

  static void onListen(data) {
    print("onListen---------------------------------------------------$data");
  }

  static void handleEvent(data) async {
    print(
        "---------------------------------ask_event_handle------------------------------------------------");
    print(data);
    //FirebaseNotifications.localNotification(data);
    connectToService();
//    NavigationService().navigateTo('/visitor_approval');
  }

  static void emit(var data) {
    /*{
    "data":
    {
    "app_id":5,
    "visitor_details":
    {
    "building_unit_id":33,
    "coming_from":"sanpada",
    "current_time":"2020-01-07 14:40:01",
    "gatekeeper_device_token":"fwlHqOKWAFs:APA91bHj3O3M0GwDGadThDNMvWzDpS1MdJcv1oIwMRDXVmYEZqnhoJvgw77PyQKnzNx8Ng7-fwpBMbTCBL6uyDcL_NU0GwuDjk6pBXIT6D8DIx72TcIJaZ0FpJWK9Gm15UzexLd-lxP8",
    "id":0,
    "image_url":"http://dev.prosimvizlog.s3-ap-southeast-1.amazonaws.com/visitors/visitor_45249000000000_large.jpg",
    "mobile_number":"919000000000",
    "notificationID":0,
    "purpose":"Delivery",
    "unit_number":"stage2 / 2001",
    "visitor_name":"Rajuk",
    "visitor_type":"guest"},
    "company_id":1094,
    "gate_device_id":"48d1838bbdd5403a",
    "member_visitor_id":8238055954796,
    "status":0,
    "unique_id":"202001071440011"
    },
    "state":1,
    "status":"allowed"}
    */

    /*{
    status: allowed, state: 1, data:
    {
    data:
     {
     app_id: 5,
      visitor_details: {building_unit_id: 33, coming_from: sanpada, current_time: 2020-01-07 14:40:01, gatekeeper_device_token: fwlHqOKWAFs:APA91bHj3O3M0GwDGadThDNMvWzDpS1MdJcv1oIwMRDXVmYEZqnhoJvgw77PyQKnzNx8Ng7-fwpBMbTCBL6uyDcL_NU0GwuDjk6pBXIT6D8DIx72TcIJaZ0FpJWK9Gm15UzexLd-lxP8, gender: M, image_url: http://dev.prosimvizlog.s3-ap-southeast-1.amazonaws.com/visitors/visitor_45249000000000_large.jpg, mobile_number: 919000000000, purpose: Delivery, unit_number: stage2 / 2001, visitor_name: Rajuk, visitor_type: guest}, company_id: 1094, gate_device_id: 48d1838bbdd5403a, in_gate: lobby, member_id: 64, member_visitor_id: 8238055954796, status: 0, unique_id: 202001071440011}}}*/
//    print("emit-----------------------------------------------------$data");
//    List list=[data];
//    print("emit- list----------------------------------------------------$list");

//    socket.emit("member_approval", data);
//    socket.emitWithAck("member_approval", data).then((data){
//      print("daaaaaaaaaaaaaaaaaaaaaaaaa");
//      print(data);
//    });
  }

  static const platform = MethodChannel('com.cubeone.app/CallingActivity');

  static Future<void> connectToService() async {
    try {
      await platform.invokeMethod<void>('connect');
      print('Connected to service');
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<String> getDataFromService() async {
    try {
      final result = await platform.invokeMethod<String>('start');
      return result;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return 'No Data From Service';
  }
}
