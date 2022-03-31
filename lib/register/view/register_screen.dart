import 'package:flutter/material.dart';
import 'package:testapp/data/repositories/authentication_repository.dart';
import 'package:testapp/register/cubit/register_cubit.dart';
import 'package:testapp/register/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(context.read<AuthenticationRepository>()),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
