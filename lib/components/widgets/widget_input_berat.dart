import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ongkir_indonesia/controllers/home/home_controller.dart';
import 'package:get/get.dart';

class BuildInputBerat extends GetView<HomeController> {
  const BuildInputBerat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: controller.beratController,
            decoration: const InputDecoration(
                labelText: "Berat Barang",
                hintText: "Masukkan Berat Barang",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            onChanged: (value) {
              // print(value);
              controller.ubahBerat(value);
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 150,
          child: DropdownSearch<String>(
            popupProps: PopupProps.bottomSheet(
              showSearchBox: true,
              showSelectedItems: true,
              loadingBuilder: (context, searchEntry) {
                return const Center(child: CircularProgressIndicator());
              },
            ),
            items: const [
              "ton",
              "kwintal",
              "ons",
              "lbs",
              "pound",
              "kg",
              "hg",
              "dag",
              "gram",
              "dg",
              "cg",
              "mg"
            ],
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                labelText: "Satuan Berat",
              ),
            ),
            onChanged: (value) {
              controller.ubahSatuan(value!);
              // print(value);
            },
            selectedItem: "gram",
          ),
        )
      ],
    );
  }
}
