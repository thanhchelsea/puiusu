class ApiConstant {
  //define all api constant like: host, path, ...
  static final apiHost = "http://192.168.36.105:3000";
  static final String LIST_EARTHQUAKE = "${apiHost}/earthquake?";
  static String QUERYl_LIST(int startTime,int endTime){
    return "timestamp_gte=${startTime}&timestamp_lte=${endTime}";
  }
  static final String LIST_CITY = "${apiHost}/city/?name_like=^";
  static final String GET_EARTHQUAKE_CITY="${apiHost}/earthquake/?region=";

}