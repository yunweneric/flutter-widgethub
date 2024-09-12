import 'package:flutter/material.dart';
import 'package:flutterui/components/presentation/templates/fruity_lips/utils/colors.dart';

class FruitItem {
  final Color color;
  final Color lightColor;
  final String colorName;

  FruitItem({
    required this.color,
    required this.lightColor,
    required this.colorName,
  });
}

List<int> list = List.generate(10, (index) => index);

List<FruitItem> baseList = [
  FruitItem(
    color: FLColors.yellow,
    colorName: "yellow",
    lightColor: FLColors.yellowLight,
  ),
  FruitItem(
    color: FLColors.green,
    colorName: "green",
    lightColor: FLColors.greenLight,
  ),
  FruitItem(
    color: FLColors.purple,
    colorName: "purple",
    lightColor: FLColors.purpleLight,
  ),
];

List<FruitItem> generateItems() {
  List<FruitItem> newList = [];
  for (var _ in list) {
    newList.addAll(baseList);
  }
  return newList;
}
