
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/data/repository/earthquake_repositorry.dart';
import 'blocs.dart';

class HomeBloc extends BaseBloc {
  static List<EarthquakeModel> listEarthquake = [];
  final EarthquakeRepository earthquakeRepository;

  HomeBloc({EarthquakeRepository earthquakeRepository})
      : this.earthquakeRepository =
            earthquakeRepository ?? EarthquakeRepository();
  @override
  // TODO: implement initialState
  BaseState get initialState => super.initialState;
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is Loading) {
      yield LoadingState();
      try {
        listEarthquake = await earthquakeRepository.getListEarthquake();
        if (listEarthquake.length != 0) {
          yield LoadedState(data: listEarthquake);
        } else {
          yield ErrorState(data: "home.empty_earthquake");
        }
      } catch (e) {
        print(e.toString() );
      }
    }
  }
}

class Loading extends BaseEvent {}
