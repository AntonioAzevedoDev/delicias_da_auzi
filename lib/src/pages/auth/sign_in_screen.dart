import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delicias_da_auzi/src/pages/auth/sign_up_screen.dart';
import 'package:delicias_da_auzi/src/pages/commom_widgets/app_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:delicias_da_auzi/src/config/custom_colors.dart';
import '../base/base_screen.dart';
import '../commom_widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:  [
                    //Email
                    CustomTextField(
                        icon: Icons.email,
                        label: 'Email',
                        isSecret: false
                    ),
                    //Senha
                    CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                    ),

                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)
                          )
                        ),
                          onPressed: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (c){
                              return BaseScreen();
                            })
                          );
                          },
                          child: const Text('Entrar', style: TextStyle(
                            fontSize: 18
                          ),)
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (c){
                                    return SignUpScreen();
                                  }
                              )
                            );
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontSize: 18
                            ),)),
                    )

                  ]
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
