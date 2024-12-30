import 'package:flutter/material.dart';

class DialogUtils {
  static Showloading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: Container(
              height: 0.1*MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                )),
          ),);
  }

  static ShowMessageDialog(
      BuildContext context,
      String message,
      {String? positiveButtom,
      void Function()? positiveActionButtom,
      String? negativeButtom,
      void Function()? negativeActionButtom,}
      ){
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              content: Text(message),
              actions: [
                positiveButtom != null
                  ?TextButton(
                    onPressed: positiveActionButtom,
                    child: Text(positiveButtom))

                  :SizedBox(),
                negativeButtom != null
                    ?TextButton(
                    onPressed: negativeActionButtom,
                    child: Text(negativeButtom))

                    :SizedBox(),
              ],
            ));
  }
}//