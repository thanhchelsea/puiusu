class PushReport {
  int idEarthquake;
  String idDevice;
  String latUser;
  String lngUser;
  int reportLevel;
  int timestampReport;

  PushReport(this.idEarthquake, this.idDevice, this.latUser, this.lngUser,
      this.reportLevel, this.timestampReport);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map["idEarthquake"] = this.idEarthquake;
    map["idDevice"] = this.idDevice;
    map["latUser"] = this.latUser;
    map["lngUser"] = this.lngUser;
    map["reportLevel"] = this.reportLevel;
    map["timestampReport"] = this.timestampReport;
    return map;
  }
}