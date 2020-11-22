import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/home_bloc.dart';
import 'package:flutter_earthquake_network/data/repository/earthquake_repositorry.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';
import 'package:intl/intl.dart';
import 'blocs/blocs.dart';
import 'blocs/blocs.dart';
import 'blocs/blocs.dart';
import 'blocs/sos_bloc.dart';
import 'blocs/sos_bloc.dart';
import 'ui/app.dart';
import 'utils/common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String language = await Common.getTypeLanguage();
  String typeMap = await Common.getTypeMap();
  EarthquakeRepository a=new EarthquakeRepository();//print(new DateTime.now().millisecondsSinceEpoch/1000);
//  a.getListCity("Bắc");
  if (language == null) {
    Common.saveTypeLanguage("vi");
    language = "vi";
  }
  if (typeMap == null) {
    Common.changTypeMap("Hybird");
    typeMap = "Hybird";
  }
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then(
    (_) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) => AppBloc(language, typeMap),
          ),
          BlocProvider<HomeBloc>(
            create: (_)=>HomeBloc(),
          ),
          BlocProvider<PhoneSetting>(
            create: (_)=>PhoneSetting(),
          ),
          BlocProvider<SOSBloc>(
            create: (_)=>SOSBloc(),
          ),
          BlocProvider<SearchBloc>(
            create: (_)=>SearchBloc(),
          )
        ],
        child: MyApp.language(language: language),
      ),
    ),
  );
}
