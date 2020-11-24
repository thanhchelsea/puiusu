import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/data/repository/earthquake_repositorry.dart';
import 'package:flutter_earthquake_network/ui/widgets/earthquake_item.dart';
import '../constants.dart';
import '../localizations.dart';
import 'blocs.dart';

class AlertBloc extends BaseBloc {
  static List<EarthquakeModel> listEarthquakeLatest = [];
  final EarthquakeRepository earthquakeRepository;

  AlertBloc({EarthquakeRepository earthquakeRepository})
      : this.earthquakeRepository =
      earthquakeRepository ?? EarthquakeRepository();
  @override
  // TODO: implement initialState
  BaseState get initialState => super.initialState;
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is LoadingNotifi) {
      yield LoadingState();
      try {
        listEarthquakeLatest = await earthquakeRepository.getLatestListEarthquake();
        if (listEarthquakeLatest != null) {
          yield LoadedState(data: listEarthquakeLatest);
        } else {
          yield ErrorState(data: "connect fail");
        }
      } catch (e) {
        print(e.toString() );
      }
    }
    if(event is AddNotification){
      yield LoadingState();
      listEarthquakeLatest.insert(0,event.e);
      yield LoadedState(data: listEarthquakeLatest);
    }
  }
}

class LoadingNotifi extends BaseEvent {}
class AddNotification extends BaseEvent{
  EarthquakeModel e;

  AddNotification(this.e);
}
