import 'package:flutter/material.dart';

class RaisedButton extends StatelessWidget {
  final Function()? buttonFunction;
  final String buttonLabel;

  const RaisedButton({
    super.key,
    required this.buttonFunction,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
      ),
      onPressed: buttonFunction,
      child: SizedBox(
        width: double.infinity,
        height: 55,
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
