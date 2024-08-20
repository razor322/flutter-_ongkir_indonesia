class Province {
  List<Results> results;

  Province({
    required this.results,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        results: List<Results>.from(
            json["rajaongkir"]["results"].map((x) => Results.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  static List<Results> fromJsonList(List<dynamic> list) {
    return list.map((item) => Results.fromJson(item)).toList();
  }
}

class Results {
  String provinceId;
  String province;

  Results({
    required this.provinceId,
    required this.province,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };

  @override
  String toString() => province;
}
