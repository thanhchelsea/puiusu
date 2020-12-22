import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/data/repository/repository.dart';

class SearchBloc extends BaseBloc {
  static List<CityModel> listCity = [];
  static List<EarthquakeModel> ListCityEarthquake=[];
  final EarthquakeRepository earthquakeRepository;

  SearchBloc({EarthquakeRepository earthquakeRepository})
      : this.earthquakeRepository =
            earthquakeRepository ?? EarthquakeRepository();

  @override
  // TODO: implement initialState
  BaseState get initialState => super.initialState;
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ChangText) {
      try {
        if (event.city.isNotEmpty) {
          yield LoadingState();
          listCity = await earthquakeRepository.getListCity(event.city);
          if (listCity.isNotEmpty) {
            print(listCity.length);
            yield LoadedState(data: listCity);
          } else {
            yield ErrorState(data: "connect fail");
          }
        } else {
          listCity.clear();
          yield LoadedState(data: listCity);
        }
      } catch (e) {
        print(e.toString());
      }
    }
    if (event is EmptyText) {
      yield InitState();
    }
    if(event is SearchEarthquke){
      yield LoadingState();
      ListCityEarthquake=await earthquakeRepository.getEarthquakeOnCity(event.city);
      if (ListCityEarthquake.isNotEmpty) {
        yield LoadedState(data: ListCityEarthquake);
      } else {
        print("k co kq nha");
        yield ErrorState(data: "search_null");
      }
    }
    if(event is SortMagntitude){
      yield LoadingState();
      print("sap xep theo do lon");
      ListCityEarthquake.sort((a, b) => b.magnitude.compareTo(a.magnitude));// sap xep theo do lon giam dan
      for(EarthquakeModel i in ListCityEarthquake){
        print(i.magnitude);
      }
      yield LoadedState(data: ListCityEarthquake);
    }
    if(event is SortTime){
      yield LoadingState();
      print("sap xep theo thoi gian");
      ListCityEarthquake.sort((a, b) => b.time.compareTo(a.time));// sap xep theo thoi gian gan nhat
      for(EarthquakeModel i in ListCityEarthquake){
        print(i.time);
      }
      yield LoadedState(data: ListCityEarthquake);
    }
  }
}

class ChangText extends BaseEvent {
  String city;
  ChangText(this.city);
  @override
  List<Object> get props => [city];
}

class EmptyText extends BaseEvent {
  @override
  List<Object> get props => [props];
  EmptyText();
}
class SortTime extends BaseEvent{

}
class SortMagntitude extends BaseEvent{

}
class SearchEarthquke extends BaseEvent{
  String city;
  SearchEarthquke(this.city);
  @override
  List<Object> get props => [city];
}
