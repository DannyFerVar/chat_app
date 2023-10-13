import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_imput_button.dart';
import 'package:chat_app/widgets/label.dart';
import 'package:chat_app/widgets/login_labels.dart';
import 'package:chat_app/widgets/logo_login.dart';
import 'package:chat_app/widgets/raised_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  Logo(screenSize: screenSize, pageTitle: 'Sign up'),
                  const _Form(),
                  const LoginLabels(
                      labelText: '¿Ya tienes una cuenta?',
                      labelTextBlue: '¡Inicia sesión ahora!',
                      route: 'login'),
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
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          InputButton(
            icon: Icons.perm_identity,
            placeholder: 'Name',
            textController: nameCtrl,
            isPasword: false,
          ),
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
                    final registerOk = await authService.register(
                      nameCtrl.text.trim(),
                      mailCtrl.text.trim(),
                      pwdCtrl.text.trim(),
                    );

                    if (registerOk == true) {
                      //TODO: Connect to socket server

                      //TODO: Navigate to next screen
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      //show alert
                      // ignore: use_build_context_synchronously
                      showAlert(
                        context,
                        'Invalid Login',
                        registerOk.toString(),
                      );
                    }
                  },
            buttonLabel: 'Sign Up',
          ),
        ],
      ),
    );
  }
}
