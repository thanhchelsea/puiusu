import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/blocs/home_bloc.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/template/hotel_app_theme.dart';

import '../../localizations.dart';
import '../../routes.dart';

class PopSearch extends StatefulWidget {
  @override
  _PopSearchState createState() => _PopSearchState();
}

class _PopSearchState extends State<PopSearch> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton(
        icon:  Icon(Icons.sort,
            color: HotelAppTheme.buildLightTheme()
                .primaryColor),
          itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<SearchBloc>(context).add(SortMagntitude());
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Text(Language.of(context).getText("search_screen.magntitude")),
                      ],
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<SearchBloc>(context).add(SortTime());
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Text(Language.of(context).getText("search_screen.time")),
                      ],
                    ),
                  ),
                )
              ]),
    );
  }
}
