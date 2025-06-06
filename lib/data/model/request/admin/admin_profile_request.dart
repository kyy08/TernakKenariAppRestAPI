import 'dart:convert';

class AdminprofilerequestModel {
    final String? name;

    AdminprofilerequestModel({
        this.name,
    });

    factory AdminprofilerequestModel.fromJson(String str) => AdminprofilerequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminprofilerequestModel.fromMap(Map<String, dynamic> json) => AdminprofilerequestModel(
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
    };
}