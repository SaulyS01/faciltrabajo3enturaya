import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String? text;
  final int? index;
  final bool buttonenabled;
  final Function? callback;

  const CustomButton({
    Key? key,
    this.text,
    this.index,
    this.buttonenabled=false,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 50,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Theme.of(context).colorScheme.onPrimary,
            primary: Theme.of(context).colorScheme.primary,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: buttonenabled?() {
            callback!(text, index);
          }:null,
          child: Text(
            text!,
            style: TextStyle(
                color: text=="X"? Colors.red: Colors.white,
                fontSize: 64
            ),
          ),
        ),
      ),
    );
  }

}