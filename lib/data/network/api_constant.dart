class ApiConstant {
  //define all api constant like: host, path, ...
  static final apiHost = "http://192.168.1.19:3000";
  static final String LIST_EARTHQUAKE = "${apiHost}/earthquake/?_sort=timestamp&_order=desc";
  static final String LIST_CITY = "${apiHost}/city/?name_like=";
  static final String GET_EARTHQUAKE_CITY="${apiHost}/earthquake/?region=";

}