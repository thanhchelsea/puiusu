import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../data/model/phone_number.dart';
import 'base_bloc/base.dart';

class SOSBloc extends BaseBloc {
  static List<PhoneNumber> dsP = [];
  SOSBloc();
  Future<bool> _sendSMS() async {
    // FUNTION gui tin nhan
    String listPhone = await Common.getListPhone();
    List<String> recipents = [];
    if (listPhone == null || listPhone.isEmpty == true) {
      return false;
    } else {
      String message = await Common.getMessageSOS();
      String message1 = await Common.getUserLocation();
      dsP = await PhoneNumber.decodeMusics(listPhone);
      for (PhoneNumber i in dsP) {
        recipents.add(i.phone);
      }
      if (message == null) message = "Giúp tôi. Tôi đang ở : !!!!!!";
      message = message + "\n" + message1;
      String _result = await FlutterSms.sendSMS(
        message: message,
        recipients: recipents,
      ).catchError(
        (onError) {
          print(onError);
        },
      );
      return true;
    }
  }

  @override
  // TODO: implement initialState
  BaseState get initialState => InitState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is LoadListPhone) {
      yield LoadingState();
      print("gg");
      String listPhone = await Common.getListPhone();
      if (listPhone != null) {
        dsP = await PhoneNumber.decodeMusics(listPhone);
      }
      yield LoadedState(data: "ok");
    }
    if (event is SendingMess) {
      yield LoadingState();
      if (await _sendSMS() == true) {
        _sendSMS();
        yield LoadedState<String>(data: "oke");
      } else {
        yield ErrorState<String>(data: "settings.error_null_phone");
        // yield InitState();
      }
    }
  }
}

class LoadListPhone extends BaseEvent {
  @override
  List<Object> get props => [props];
}

class SendingMess extends BaseEvent {}
