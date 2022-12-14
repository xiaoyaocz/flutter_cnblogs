import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cnblogs/app/app_style.dart';
import 'package:flutter_cnblogs/generated/locales.g.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NumberStepDialog extends StatelessWidget {
  final int value;
  final int max;
  final int min;
  final int step;
  final bool resetOnMaxOrMin;
  final bool isUpDownIcon;

  NumberStepDialog({
    required this.value,
    required this.min,
    required this.max,
    this.step = 1,
    this.resetOnMaxOrMin = false,
    this.isUpDownIcon = false,
    Key? key,
  }) : super(key: key) {
    var myValue = value;
    if (value < min) {
      myValue = min;
    }
    valueTemp.value = myValue;
    textEditingController.text = myValue.toString();
  }
  var valueTemp = 0.obs;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // actionsPadding: EdgeInsets.zero,
      // contentPadding: AppStyle.edgeInsetsA12,
      // buttonPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 48),
      child: Padding(
        padding: AppStyle.edgeInsetsA12.copyWith(bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppStyle.vGap12,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildButton(
                  iconData: isUpDownIcon ? Icons.expand_more : Icons.remove,
                  onPressed: () {
                    //减
                    if (valueTemp.value <= min) {
                      if (resetOnMaxOrMin) {
                        valueTemp.value = max;
                      } else {
                        valueTemp.value = min;
                      }
                    } else {
                      valueTemp.value = valueTemp.value - step;
                    }
                    if (valueTemp.value < min) {
                      valueTemp.value = min;
                    } else if (valueTemp.value > max) {
                      valueTemp.value = max;
                    }
                    textEditingController.text = valueTemp.value.toString();
                  },
                ),
                Container(
                  width: 120,
                  height: 48,
                  margin: AppStyle.edgeInsetsH8,
                  child: TextField(
                    controller: textEditingController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue.shade300,
                          width: 2,
                        ),
                        borderRadius: AppStyle.radius4,
                      ),
                      contentPadding:
                          AppStyle.edgeInsetsA12.copyWith(top: 0, bottom: 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue.shade300,
                          width: 2,
                        ),
                        borderRadius: AppStyle.radius4,
                      ),
                    ),
                    onSubmitted: (e) {
                      var val = int.tryParse(e);
                      if (e.isEmpty || val == null) {
                        textEditingController.text = value.toString();
                        return;
                      }
                      if (val < min) {
                        val = min;
                      } else if (val > max) {
                        val = max;
                      }
                      textEditingController.text = val.toString();
                    },
                  ),
                ),
                buildButton(
                  iconData: isUpDownIcon ? Icons.expand_less : Icons.add,
                  onPressed: () {
                    //加
                    if (valueTemp.value >= max) {
                      if (resetOnMaxOrMin) {
                        valueTemp.value = min;
                      } else {
                        valueTemp.value = max;
                      }
                    } else {
                      valueTemp.value = valueTemp.value + step;
                    }

                    if (valueTemp.value < min) {
                      valueTemp.value = min;
                    } else if (valueTemp.value > max) {
                      valueTemp.value = max;
                    }
                    textEditingController.text = valueTemp.value.toString();
                  },
                ),
              ],
            ),
            AppStyle.vGap12,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: Get.back,
                    style: ElevatedButton.styleFrom(),
                    child: Text(
                      LocaleKeys.dialog_cancel.tr,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      var val = int.tryParse(textEditingController.text);
                      if (textEditingController.text.isEmpty || val == null) {
                        textEditingController.text = value.toString();
                        return;
                      }
                      if (val < min) {
                        val = min;
                      } else if (val > max) {
                        val = max;
                      }
                      Get.back(result: val);
                    },
                    child: Text(LocaleKeys.dialog_confirm.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({required IconData iconData, Function()? onPressed}) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyle.radius8,
          ),
        ),
        onPressed: onPressed,
        child: Icon(
          iconData,
          size: 32,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}
