import 'package:flutter_earthquake_network/data/model/model.dart';
import 'blocs.dart';

class MapReportBloc extends BaseBloc {
   static  List<ReportModel> listRepoprt;

  @override
  // TODO: implement initialState
  BaseState get initialState => super.initialState;
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if(event is LoadReport){
      yield LoadSuccess();
    }
  }

}
class LoadReport extends BaseEvent{}
class LoadSuccess extends BaseState{}