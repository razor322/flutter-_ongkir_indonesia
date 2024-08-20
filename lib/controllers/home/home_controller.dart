import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isHiddenAsal = true.obs;
  var provIdAsal = 0.obs;
  var kotaIdAsal = 0.obs;
  var isHiddenTujuan = true.obs;
  var provIdTujuan = 0.obs;
  var kotaIdTujuan = 0.obs;
  double berat = 0.0;
  String satuan = "gram";
  late TextEditingController beratController;

  void ubahSatuan(String value) {
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

    print("ubah berat $berat $value");
  }

  void ubahBerat(String value) {
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
    print("berat $satuan");
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
