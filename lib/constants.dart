import 'dart:ui';

const Color backgroundPrimaryColor = Color.fromRGBO(27, 27, 27, 1);
String getStringStyling({required String text}) {
  String str = "";
  int length = text.length;
  int count = 0;
  for (int i = length - 1; i >= 0; i--) {
    if (count == 3) {
      count = 0;
      str += " ";
    }
    str += "${text[i]}";
    count++;
  }
  String tempString = "";
  for (int i = str.length - 1; i >= 0; i--) {
    tempString += str[i];
  }
  return tempString;
}
