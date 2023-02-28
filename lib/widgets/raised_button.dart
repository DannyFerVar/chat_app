import 'package:flutter/material.dart';

class RaisedButton extends StatelessWidget {
  final Function() buttonFunction;
  final String buttonLabel;

  const RaisedButton({
    super.key,
    required this.buttonFunction,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: buttonFunction,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
