import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/ui/template/hotel_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/pop_search.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

import 'earthquake_item.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<EarthquakeModel> list = new List<EarthquakeModel>();
  final ScrollController _scrollController = ScrollController();
  TextEditingController _txtController = new TextEditingController();
  bool _isShowSuggest = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: BlocConsumer<SearchBloc, BaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BaseScreenMethod(
            iconBack: true,
            title: 'search',
            body: BlocConsumer<SearchBloc,BaseState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                return NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                getSearchBarUI(),
                                state is LoadedState<List<CityModel>>
                                    ? Container(
                                  //  color: HotelAppTheme.buildLightTheme().backgroundColor,
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  width:
                                  DeviceUtil.getDeviceWidth(context),
                                  child: Column(
                                    children: List.generate(
                                        state.data.length, (index) {
                                      return InkWell(
                                        onTap: () {
                                          _txtController.text = "";
                                          setState(() {
                                            _isShowSuggest = false;
                                            //  BlocProvider.of<SearchBloc>(context).add(EmptyText());
                                            BlocProvider.of<SearchBloc>(
                                                context)
                                                .add(SearchEarthquke(state
                                                .data[index].name));
                                          });
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Icon(
                                                Icons.stars,
                                                color: HotelAppTheme
                                                    .buildLightTheme()
                                                    .primaryColor,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 20,
                                                top: 10,
                                                bottom: 10,),
                                              child: Text(
                                                state.data[index].name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w600,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                  alignment: Alignment.centerLeft,
                                )
                                    : Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                )
                                //getTimeDateUI(),
                              ],
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: ContestTabHeader(
                          _isShowSuggest == false
                              ? getFilterBarUI()
                              : Container(),
                        ),
                      ),
                    ];
                  },
                  body: state is LoadedState<List<EarthquakeModel>>
                      ? Container(
                    color:
                    HotelAppTheme.buildLightTheme().backgroundColor,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return EarthquakeItem(state.data[index], index);
                      },
                    ),
                  )
                      : state is ErrorState<String>
                      ? Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.topCenter,
                    child: Text(
                        Language.of(context).getText(state.data)),
                  )
                      : Container(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: _txtController,
                    onTap: () {
                      setState(() {
                        _isShowSuggest = true;
                      });
                    },
                    onChanged: (txt) {

                      if (txt.isEmpty) {
                        print("null");
                        BlocProvider.of<SearchBloc>(context).add(EmptyText());
                      }else BlocProvider.of<SearchBloc>(context).add(ChangText(txt));
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '${Language.of(context).getText('search')}...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  BlocProvider.of<SearchBloc>(context)
                      .add(ChangText(_txtController.text));
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.search,
                      size: 20,
                      color: HotelAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HotelAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            Language.of(context).getText("search_screen.sort"),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Center(
                              child:PopSearch()
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
