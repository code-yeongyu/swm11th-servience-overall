String beautifyPrice(int price) {
  String stringPrice = price.toString();
  int stringLength = stringPrice.length;
  if (stringLength > 3) {
    for (int i = stringLength - 3; i > 0; i -= 3) {
      stringPrice = stringPrice.substring(0, i) +
          "," +
          stringPrice.substring(i, stringLength);
    }
  }
  return "₩ " + stringPrice;
}
