import 'package:chat_app_two/view/chat_page.dart';
import 'package:chat_app_two/view/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app_two/view/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app_two/view/cubits/register_cubit/register_cubit.dart';

import 'package:chat_app_two/view/login_page.dart';
import 'package:chat_app_two/view/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        )
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'LoginPage', /*بدل ال الهوم بستعملها*/
      ),
    );
  }
}
