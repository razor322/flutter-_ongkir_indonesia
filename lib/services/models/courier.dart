// To parse this JSON data, do
//
//     final courier = courierFromJson(jsonString);

import 'dart:convert';

Courier courierFromJson(String str) => Courier.fromJson(json.decode(str));

String courierToJson(Courier data) => json.encode(data.toJson());

class Courier {
  Rajaongkir rajaongkir;

  Courier({
    required this.rajaongkir,
  });

  factory Courier.fromJson(Map<String, dynamic> json) => Courier(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
      );

  Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
      };
}

class Rajaongkir {
  List<Result> results;

  Rajaongkir({
    required this.results,
  });

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String code;
  String name;
  List<ResultCost> costs;

  Result({
    required this.code,
    required this.name,
    required this.costs,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        name: json["name"],
        costs: List<ResultCost>.from(
            json["costs"].map((x) => ResultCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
      };
}

class ResultCost {
  String service;
  String description;
  List<CostCost> cost;

  ResultCost({
    required this.service,
    required this.description,
    required this.cost,
  });

  factory ResultCost.fromJson(Map<String, dynamic> json) => ResultCost(
        service: json["service"],
        description: json["description"],
        cost:
            List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
      };
}

class CostCost {
  int value;
  String etd;
  String note;

  CostCost({
    required this.value,
    required this.etd,
    required this.note,
  });

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
