import 'package:flutter/material.dart';
import 'package:flutter_ongkir_indonesia/services/models/courier.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var isHiddenAsal = true.obs;
  var provIdAsal = 0.obs;
  var kotaIdAsal = 0.obs;
  var isHiddenTujuan = true.obs;
  var provIdTujuan = 0.obs;
  var kotaIdTujuan = 0.obs;
  var isHiddenBtn = true.obs;
  var kurir = "".obs;

  double berat = 0.0;
  String satuan = "gram";
  late TextEditingController beratController;

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;

    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204 / 62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    print("$berat gram");
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratController.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204 / 62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
    satuan = value;
    print("$berat gram");
  }

  void showBtn() {
    if (kotaIdAsal.value != 0 &&
        kotaIdTujuan.value != 0 &&
        berat.isGreaterThan(0) &&
        kurir != "") {
      isHiddenBtn.value = false;
    } else {
      isHiddenBtn.value = true;
    }
  }

  formatRupiah(int amount) {
    final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
        customPattern: '#,##0');
    return formatter.format(amount);
  }

  ongkosKirim() async {
    try {
      var url = "https://api.rajaongkir.com/starter/cost";
      final response = await http.post(Uri.parse(url), headers: {
        "key": "6c7c3ea1ce5ee3eb9ab5e24f7b1fa808",
        "content-type": "application/x-www-form-urlencoded",
      }, body: {
        "origin": kotaIdAsal.value.toString(),
        "destination": kotaIdTujuan.value.toString(),
        "weight": berat.toString(),
        "courier": kurir.value.toString()
      });
      // var data = jsonDecode(response.body);
      // var result = data["rajaongkir"]["results"];
      var data = courierFromJson(response.body).rajaongkir.results;
      // var result = data["rajaongkir"]["results"];
      // var list = Cost.fromJsonList(data);
      print(data);
      var courier = data[0];
      Get.defaultDialog(
          title: courier.name,
          content: Column(
            children: courier.costs
                .map(
                  (e) => ListTile(
                    title: Text(e.service.toString()),
                    subtitle: Text("Rp. ${formatRupiah(e.cost[0].value)}"),
                    trailing: Text(courier.code == "pos"
                        ? e.cost[0].etd.toString()
                        : "${e.cost[0].etd.toString()} hari"),
                  ),
                )
                .toList(),
          ));

      // var listAllCourier = ResultCost.fromJson(result);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    beratController = TextEditingController(text: berat.toString());
    super.onInit();
  }

  @override
  void onClose() {
    beratController.dispose();
    super.onClose();
  }
}
