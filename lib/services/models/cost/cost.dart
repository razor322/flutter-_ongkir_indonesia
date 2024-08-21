class Cost {
  String code;
  String name;
  List<CostCost> costs;

  Cost({
    required this.code,
    required this.name,
    required this.costs,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        code: json["code"],
        name: json["name"],
        costs: List<CostCost>.from(json["rajaongkir"]["results"]["costs"]
            .map((x) => CostCost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
      };
  static List<Cost> fromJsonList(List<dynamic> list) {
    return list.map((item) => Cost.fromJson(item)).toList();
  }
}

class CostCost {
  String service;
  String description;
  List<CostCostClass> cost;

  CostCost({
    required this.service,
    required this.description,
    required this.cost,
  });

  factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        service: json["service"],
        description: json["description"],
        cost: List<CostCostClass>.from(
            json["cost"].map((x) => CostCostClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
      };
}

class CostCostClass {
  int value;
  String etd;
  String note;

  CostCostClass({
    required this.value,
    required this.etd,
    required this.note,
  });

  factory CostCostClass.fromJson(Map<String, dynamic> json) => CostCostClass(
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
