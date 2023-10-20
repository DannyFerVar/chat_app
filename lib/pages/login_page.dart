// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/raised_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/widgets/login_labels.dart';
import 'package:chat_app/widgets/label.dart';
import 'package:chat_app/widgets/custom_imput_button.dart';
import 'package:chat_app/widgets/logo_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Logo(screenSize: screenSize, pageTitle: 'Messenger'),
                  const _Form(),
                  const LoginLabels(
                      labelText: '¿No tienes una cuenta?',
                      labelTextBlue: '¡Crea una cuenta ahora!',
                      route: 'register'),
                  const Label(labelName: 'Terminos y condiciones'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final mailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          InputButton(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: mailCtrl,
            isPasword: false,
          ),
          InputButton(
            icon: Icons.lock,
            placeholder: 'Password',
            textController: pwdCtrl,
            isPasword: true,
          ),
          RaisedButton(
            buttonFunction: authService.authenticating
                ? () => {}
                : () async {
                    FocusScope.of(context).unfocus();

                    final loginOk = await authService.login(
                        mailCtrl.text.trim(), pwdCtrl.text.trim());

                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(context, 'Invalid Login',
                          'please verify your information');
                    }
                  },
            buttonLabel: 'Login',
          ),
        ],
      ),
    );
  }
}
