import 'dart:convert';

UserData loginArgsFromJson(String str) => UserData.fromJson(json.decode(str));

String loginArgsToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.userName,
    this.pass,
    this.name,
    this.id,
    this.checkPoint,
  });

  String? pass;
  String? userName;
  int? id;
  String? name;
  String? checkPoint;


  UserData copyWith({
    String? pass,
    String? userName,
    int? id,
    String? name,
    String? checkPoint,
  }) =>
      UserData(
        pass: pass ?? this.pass,
        userName: userName ?? this.userName,
        id: id ?? this.id,
        name: name ?? this.name,
         checkPoint: checkPoint ?? this.checkPoint,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    pass: json["pass"] == null ? null : json["pass"],
    userName: json["userName"] == null ? null : json["userName"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    checkPoint: json["checkPoint"] == null ? null : json["checkPoint"],
  );

  Map<String, dynamic> toJson() => {
    "pass": pass == null ? null : pass,
    "userName": userName == null ? null : userName,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "checkPoint": checkPoint == null ? null :checkPoint,
  };
}
