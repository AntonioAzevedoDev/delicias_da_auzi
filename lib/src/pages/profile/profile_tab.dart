import 'package:delicias_da_auzi/src/pages/commom_widgets/custom_text_field.dart';
import 'package:delicias_da_auzi/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/controller/auth_controller.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Email
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.email,
              icon: Icons.email,
              label: 'Email'),
          //Nome
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.name,
              icon: Icons.person,
              label: 'Nome'),
          //Celular
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.phone,
              icon: Icons.phone,
              label: 'Celular'),
          //CPF
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),
          //Botão para atualizar senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.purple),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  updatePassword();
                },
                child: const Text('Atualizar senha')),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 150),
            scrollDirection: Axis.vertical,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Atualização de senha',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha atual',
                            isSecret: true,
                            validator: passwordValidator,
                            controller: currentPasswordController,
                          ),
                          CustomTextField(
                            icon: Icons.lock_outline,
                            label: 'Nova senha',
                            isSecret: true,
                            validator: passwordValidator,
                          ),
                          CustomTextField(
                            icon: Icons.lock_outline,
                            controller: newPasswordController,
                            label: 'Confirmar nova senha',
                            isSecret: true,
                            validator: (password) {
                              final result = passwordValidator(password);
                              if (result != null) {
                                return result;
                              }
                              if (password != newPasswordController.text) {
                                return 'As senhas não são equivalentes!';
                              }
                              return null;
                            },
                          ),
                          //Botão de confirmação
                          SizedBox(
                            height: 45,
                            child: Obx(() => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          authController.changePassword(
                                            currentPassword: currentPasswordController.text,
                                            newPassword: newPasswordController.text,
                                          );
                                        }
                                      },
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text('Atualizar'))),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
