class City {
  List<Data> results;

  City({
    required this.results,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        results: List<Data>.from(
            json["rajaongkir"]["results"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  static List<Data> fromJsonList(List<dynamic> list) {
    return list.map((item) => Data.fromJson(item)).toList();
  }
}

class Data {
  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;
  String postalCode;

  Data({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };
  @override
  String toString() => cityName;
}

class Status {
  int code;
  String description;

  Status({
    required this.code,
    required this.description,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
