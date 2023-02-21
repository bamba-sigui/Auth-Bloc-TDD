import 'package:flutter/material.dart';

const lightGrey = Color(0xfff1f4f6);
const lightBlue =  Color(0xffb0d5ee);
const darkBlue =  Color(0xff284059);
const red =  Color(0xffe04f59);
const lightRed =  Color(0xfffab6b5);
const light =  Color(0xfff5f3eb);
const white =  Color(0xffffffff);

List<Color> colors = [lightBlue, darkBlue, lightRed, red, light, white];

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('0x', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}