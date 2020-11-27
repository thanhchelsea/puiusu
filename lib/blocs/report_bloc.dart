import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/data/repository/repository.dart';

class ReportBloc extends BaseBloc {
  static bool reportDone = false;
  static List<ReportModel> listReport=[];
  final EarthquakeRepository earthquakeRepository;

  ReportBloc({EarthquakeRepository earthquakeRepository})
      : this.earthquakeRepository =
            earthquakeRepository ?? EarthquakeRepository();

  @override
  // TODO: implement initialState
  BaseState get initialState => super.initialState;
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if(event is getReport){
      yield LoadingState();
      print("yeu cau geet list report");
      listReport=await earthquakeRepository.getReport(event.idEarthquke);
      if(listReport!=null){
        yield LoadedState(data:listReport);
      }
      else yield ErrorState(data: "no report");
    }
    if (event is Report) {
      yield LoadingState();
      bool success =
          await earthquakeRepository.postReport(event.level, event.id);
      if (success == true) {
        yield SuccessReport();
      }
    }
  }
}

class Report extends BaseEvent {
  int level;
  int id;

  Report({this.level, this.id});

  @override
  List<Object> get props => [level, id];
}
class getReport extends BaseEvent{
  int idEarthquke;
  getReport(this.idEarthquke);

}
class SuccessReport extends BaseState {}

class FailReport extends BaseState {}
