class Users {
  Users({
    this.id,
    this.username,
    this.password,
    this.eMail,
    this.adress,
    this.telno,
    this.veteriner,
    this.regionAlarm,
    this.heatAlarm,
    this.sifre2,
  });

  int id;
  String username;
  String password;
  String eMail;
  String adress;
  String telno;
  String veteriner;
  int regionAlarm;
  int heatAlarm;
  String sifre2;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        eMail: json["e_mail"],
        adress: json["adress"],
        telno: json["telno"],
        veteriner: json["veteriner"],
        regionAlarm: json["region_alarm"],
        heatAlarm: json["heat_alarm"],
        sifre2: json["sifre2"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['e_mail'] = this.eMail;
    data['adress'] = this.adress;
    data['telno'] = this.telno;
    data['veteriner'] = this.veteriner;
    data['region_alarm'] = this.regionAlarm;
    data['heat_alarm'] = this.heatAlarm;
    data['sifre2'] = this.sifre2;
    return data;
  }
}
