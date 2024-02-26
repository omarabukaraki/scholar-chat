import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:chat_app_two/helper/show_snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/custom_button.dart';
import '../component/custom_textFiled.dart';
import '../constant.dart';
import 'chat_page.dart';
import 'cubits/chat_cubit/chat_cubit.dart';
import 'cubits/register_cubit/register_cubit.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';
  String? email;
  String? password;
  String? name;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLodging) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSankBar(context, state.errMassage);
        }
      },
      builder: (context, state) {
        return BlurryModalProgressHUD(
          inAsyncCall: isLoading,
          blurEffectIntensity: 2,
          color: KPrimaryColor,
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Color(0xffc7ede6),
            strokeWidth: 7,
          ),
          child: Scaffold(
              backgroundColor: KPrimaryColor,
              body: SafeArea(
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 75),
                      Image.asset(
                        KLogo,
                        height: 100,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Scholar Chat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 75),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormTextField(
                          hintText: 'Email',
                          icon: Icons.email,
                          onChanged: (value) {
                            email = value;
                          }),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        onChanged: (value) {
                          password = value;
                        },
                        typeText: true,
                        hintText: 'password',
                        icon: Icons.lock,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Register',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                                .registerUser(
                                    email: email!, password: password!);
                          } else {}
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "already have an account ?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Color(0xffc7ede6)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
