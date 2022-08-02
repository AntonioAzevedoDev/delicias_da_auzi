import 'package:delicias_da_auzi/src/pages/auth/controller/auth_controller.dart';
import 'package:delicias_da_auzi/src/pages/commom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/validators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final _emailController = TextEditingController();
  final authController = Get.find<AuthController>();
  ForgotPasswordDialog({Key? key, required String email}) : super(key: key) {
    _emailController.text = email;
  }
  final formFieldKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        //Conteudo
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Título
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Recuperação de senha',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                //Descrição
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Digite seu email para recuperar sua senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                //Campo de Email
                CustomTextField(
                  formFieldKey: formFieldKey,
                  controller: _emailController,
                  icon: Icons.email,
                  label: 'Email',
                  validator: emailValidator,
                ),
                //Confirmar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      side: const BorderSide(width: 2, color: Colors.purple)),
                  onPressed: () {
                    if(formFieldKey.currentState!.validate()){
                      authController.resetPassword(_emailController.text);
                      Get.back(result: true);
                    }
                  },
                  child: const Text(
                    'Recuperar',
                    style: TextStyle(fontSize: 13),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          )
        ],
      ),
    );
  }
}
