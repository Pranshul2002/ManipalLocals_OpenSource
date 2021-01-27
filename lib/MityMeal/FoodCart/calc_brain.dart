import 'lists.dart';

class CalcBrain {
  double itemTotal = 0.0;
  double cartTotal = 0.0;

  double totalPerItem() {
    itemTotal = 0.0;

    for (int i = 0; i < MyLists.price.length; i++) {
      itemTotal = itemTotal + (MyLists.price[i] * MyLists.qty[i]);
    }
    double sum = 0;
    MyLists.qty.forEach((num e) {
      sum += e;
    });
    MyLists.deliveryCharges = sum * 5 + 7;
    return itemTotal;
  }

  double entireCartTotal() {
    cartTotal = 0.0;
    cartTotal = itemTotal + MyLists.deliveryCharges;
    return cartTotal;
  }
}
