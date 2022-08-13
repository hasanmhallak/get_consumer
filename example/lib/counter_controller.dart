import 'package:get/get.dart';

class CounterController extends GetxController with StateMixin<int> {
  CounterController() {
    // onInit might take some time to excute, so we change the state
    // in the constructor body.
    change(0, status: RxStatus.success());
  }

  final number = 0.obs;

  void updateState() => change(state! + 1, status: RxStatus.success());

  void updateNumber() => number.value += 1;
}
