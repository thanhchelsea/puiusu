class ApiConstant {
  //define all api constant like: host, path, ...
  static final apiHost = "http://192.168.1.31:3000";
  static final String LIST_EARTHQUAKE = "${apiHost}/earthquake?_sort=timestamp&_order=desc&";
  static final String LIST_CITY = "${apiHost}/city/?name_like=^";
  static final String GET_EARTHQUAKE_CITY="${apiHost}/earthquake/?region=";
  static final String Report_EARTHQUAKE="${apiHost}/report";
  static final String GET_REPORT_EARTHQUAKE="${Report_EARTHQUAKE}?idEarthquake=";
  static String QUERYl_LIST(int startTime,int endTime){
    return "timestamp_gte=${startTime}&timestamp_lte=${endTime}";
  }
}