import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delicias_da_auzi/src/pages/auth/controller/auth_controller.dart';
import 'package:delicias_da_auzi/src/pages/auth/sign_up_screen.dart';
import 'package:delicias_da_auzi/src/pages/commom_widgets/app_name_widget.dart';
import 'package:delicias_da_auzi/src/pages_routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:delicias_da_auzi/src/config/custom_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../base/base_screen.dart';
import '../commom_widgets/custom_text_field.dart';
import 'package:delicias_da_auzi/src/pages/auth/controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  //Controlador de campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     AppNameWidget(
                       purpleTitleColor: Colors.white,
                       textSize: 40,
                     ),
                     //Categorias
                     SizedBox(
                       height: 30,
                       child: DefaultTextStyle(
                         style: const TextStyle(
                           fontSize: 25,
                         ),
                         child: AnimatedTextKit(
                             pause: Duration.zero,
                             repeatForever: true,
                             animatedTexts: [
                               FadeAnimatedText('Doces'),
                               FadeAnimatedText('Salgados'),
                               FadeAnimatedText('Bolos Gourmet'),
                               FadeAnimatedText('Kit Festa'),
                         ]),
                       ),
                     )
                  ],
                )
              ),
              //Formulario
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45)
                  )
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:  [
                      //Email
                      CustomTextField(
                          controller: emailController,
                          icon: Icons.email,
                          label: 'Email',
                          isSecret: false,
                          validator: (email){
                            if(email == null || email.isEmpty) return 'Digite seu email!';
                            if(!email.isEmail) return 'Digite um email válido!';

                            return null;
                          },
                      ),
                      //Senha
                      CustomTextField(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: 'Senha',
                          isSecret: true,
                        validator: (password){
                          if(password == null || password.isEmpty) return 'Digite sua senha!';
                          if(password.length < 7) return 'Digite uma senha com pelo menos 7 caracteres.';

                        },
                      ),

                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authController){
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18)
                                    )
                                ),
                                onPressed: authController.isLoading.value ? null : (){
                                  FocusScope.of(context).unfocus();

                                  if(_formKey.currentState!.validate()){
                                    String email = emailController.text;
                                    String password = passwordController.text;
                                    authController.signIn(email: email, password: password);
                                  }
                                  else{
                                    print('Campos não válidos');
                                  }
                                  // Get.offNamed(PagesRoutes.baseRoute);
                                },
                                child: authController.isLoading.value ?
                                CircularProgressIndicator() :
                                const Text('Entrar', style: TextStyle(
                                    fontSize: 18
                                ),)
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: (){},
                            child: Text(
                              'Esqueceu a senha ?',
                              style: TextStyle(
                                color: CustomColors.customConstratColor
                            ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 15),
                              child:  Text(
                                  'Ou'
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.purple
                            )
                          ),
                            onPressed: (){
                              Get.toNamed(PagesRoutes.signUpRoute);
                            },
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: 18
                              ),)),
                      )

                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
