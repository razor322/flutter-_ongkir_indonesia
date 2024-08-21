import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ongkir_indonesia/components/widgets/widget_input_berat.dart';
import 'package:flutter_ongkir_indonesia/controllers/home/home_controller.dart';
import 'package:flutter_ongkir_indonesia/services/models/city/city.dart';
import 'package:flutter_ongkir_indonesia/services/models/province/province.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});
  final HomeController c = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ongkir"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Kota Asal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            _dropdownProvinsi("Provinsi Asal"),
            const SizedBox(
              height: 20,
            ),
            Obx(() => c.isHiddenAsal.isTrue
                ? const SizedBox()
                : _dropdownKota(c.provIdAsal.value, "Asal")),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Kota Tujuan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            _dropdownProvinsi("Provinsi Tujuan"),
            const SizedBox(
              height: 20,
            ),
            Obx(() => c.isHiddenTujuan.isTrue
                ? const SizedBox()
                : _dropdownKota(c.provIdTujuan.value, "Tujuan")),
            const SizedBox(
              height: 20,
            ),
            const BuildInputBerat(),
            const SizedBox(
              height: 20,
            ),
            _dropdownCourier(),
            const SizedBox(
              height: 20,
            ),
            Obx(() => c.isHiddenBtn.isTrue ? const SizedBox() : _buildButton())
          ],
        ),
      ),
    );
  }

  Widget _dropdownProvinsi(String tipe) {
    return DropdownSearch<Results>(
      popupProps: const PopupProps.menu(showSearchBox: true),
      asyncItems: (String filter) async {
        try {
          var url = "https://api.rajaongkir.com/starter/province";
          final response = await http.get(Uri.parse(url), headers: {
            "key": "6c7c3ea1ce5ee3eb9ab5e24f7b1fa808",
          });

          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            var listAllResults = Province.fromJson(data).results;
            return listAllResults;
          } else {
            throw Exception('Failed to load data');
          }
        } catch (e) {
          print(e);
          return List<Results>.empty();
        }
      },
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem?.province ?? 'Pilih $tipe');
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: const Icon(Icons.location_on)),
      ),
      itemAsString: (Results u) => u.province,
      onChanged: (data) {
        if (data != null) {
          if (tipe == "Provinsi Asal") {
            print("ada data ${data.province}");
            controller.isHiddenAsal.value = false;
            controller.provIdAsal.value = int.parse(data.provinceId);
          } else {
            controller.isHiddenTujuan.value = false;
            controller.provIdTujuan.value = int.parse(data.provinceId);
          }
        } else {
          if (tipe == "Provinsi Asal") {
            controller.isHiddenAsal.value = true;
            controller.provIdAsal.value = 0;
          } else {
            controller.isHiddenTujuan.value = true;
            controller.provIdTujuan.value = 0;
          }
        }
        controller.showBtn();
      },
      clearButtonProps:
          const ClearButtonProps(icon: Icon(Icons.clear), isVisible: true),
    );
  }

  Widget _dropdownKota(int prov, String tipe) {
    return DropdownSearch<Data>(
      popupProps: const PopupProps.menu(showSearchBox: true),
      asyncItems: (String filter) async {
        try {
          var url = "https://api.rajaongkir.com/starter/city?province=$prov";
          final response = await http.get(Uri.parse(url), headers: {
            "key": "6c7c3ea1ce5ee3eb9ab5e24f7b1fa808",
          });

          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            var listAllResults = City.fromJson(data).results;
            return listAllResults;
          } else {
            throw Exception('Failed to load data');
          }
        } catch (e) {
          print(e);
          return List<Data>.empty();
        }
      },
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem?.cityName ?? 'Pilih Kota $tipe');
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: const Icon(Icons.location_on)),
      ),
      itemAsString: (Data u) => u.cityName,
      onChanged: (data) {
        print(data?.cityName);
        if (data != null) {
          if (tipe == "Asal") {
            print("ada data ${data.province}");
            controller.kotaIdAsal.value = int.parse(data.cityId);
          } else {
            controller.kotaIdTujuan.value = int.parse(data.cityId);
          }
        } else {
          if (tipe == "Asal") {
            controller.kotaIdAsal.value = 0;
          } else {
            controller.kotaIdTujuan.value = 0;
          }
        }
        controller.showBtn();
      },
      clearButtonProps:
          const ClearButtonProps(icon: Icon(Icons.clear), isVisible: true),
    );
  }

  Widget _dropdownCourier() {
    return DropdownSearch<String>(
      popupProps: const PopupProps.bottomSheet(
        fit: FlexFit.loose,
      ),
      items: const ["jne", "tiki", "pos"],
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          prefixIcon: Icon(Icons.backpack),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          labelText: "Pilihan Courier",
        ),
      ),
      clearButtonProps:
          const ClearButtonProps(icon: Icon(Icons.clear), isVisible: true),
      onChanged: (value) {
        if (value != null) {
          controller.kurir.value = value;
          controller.showBtn();
          print(value);
        } else {
          controller.isHiddenBtn.value = true;
          controller.kurir.value = "";
        }
      },
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(15),
        ),
        onPressed: () {
          controller.ongkosKirim();
        },
        child: const Text(
          "CEK ONGKOS KIRIM",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ));
  }
}
