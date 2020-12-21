import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../data/model/phone_number.dart';
import '../utils/common.dart';
import 'base_bloc/base.dart';

class PhoneSetting extends BaseBloc {
  static List<PhoneNumberContact> dsPhone = [];

  @override
  // TODO: implement initialState
  BaseState get initialState => super.initialState;
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

    if (event is LoadPhone) {
      String listP = await Common.getListPhone();
      if (listP != null) {
        dsPhone = PhoneNumberContact.decodeMusics(listP);
      }
      yield SavedPhone();
    }
    if (event is SaveListPhone) {
      String listP = await Common.getListPhone();
      if (listP != null) {
        dsPhone = PhoneNumberContact.decodeMusics(listP);
      }
      dsPhone.add(event.phone);
      String saveListPhone = PhoneNumberContact.encodeMusics(dsPhone);
      await Common.saveListPhone(saveListPhone);
      yield ShowListPhone(data: dsPhone);
    }
    if (event is DeletePhone) {
      String listP = await Common.getListPhone();
      if (listP != null) {
        dsPhone = PhoneNumberContact.decodeMusics(listP);
      }
      dsPhone.removeAt(event.phone);

      String saveListPhone = PhoneNumberContact.encodeMusics(dsPhone);
      await Common.saveListPhone(saveListPhone);
      yield ShowListPhone(data: dsPhone);
    }
    if (event is EditPhone) {
      String listP = await Common.getListPhone();
      if (listP != null) {
        dsPhone = PhoneNumberContact.decodeMusics(listP);
      }
      for(int i=0;i<dsPhone.length;i++){
        if(i==event.phone){
          dsPhone.removeAt(event.phone);
          print(event.p.phone);
          dsPhone.insert(event.phone, event.p);
          break;
        }
      }
      String saveListPhone = PhoneNumberContact.encodeMusics(dsPhone);
      await Common.saveListPhone(saveListPhone);
      yield ShowListPhone(data: dsPhone);
    }
  }

  PhoneSetting();
}

class ShowListPhone<T> extends BaseState {
  T data;

  ShowListPhone({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];
}

class SavedPhone extends BaseState {
  @override
  List<Object> get props => [];
}

class LoadPhone extends BaseEvent {
  @override
  List<Object> get props => [];
}

class SaveListPhone extends BaseEvent {
  PhoneNumberContact phone;

  SaveListPhone(this.phone);
  @override
  List<Object> get props => [phone];
}

class DeletePhone extends BaseEvent {
  int phone;

  DeletePhone(this.phone);
  @override
  List<Object> get props => [phone];
}
class EditPhone extends BaseEvent{
  int phone;PhoneNumberContact p;
  EditPhone(this.phone,this.p);
  @override
  List<Object> get props => [phone,p];
}
