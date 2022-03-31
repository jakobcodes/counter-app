import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/app/app.dart';
import 'package:testapp/data/models/user.dart';
import 'package:testapp/data/repositories/authentication_repository.dart';
import 'package:testapp/profile/cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(context.read<AuthenticationRepository>()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _AppBar(),
        ),
        body: ListView(
          children: [
            _Avatar(),
            _UsernameCard(),
            _EmailCard(),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return AppBar(
          title: Text('Profile: ' + state.username),
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 64,
            child: Icon(Icons.person),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Change avatar'),
          )
        ],
      ),
    );
  }
}

class _UsernameCard extends StatelessWidget {
  const _UsernameCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text("username"),
      ),
    );
  }
}

class _EmailCard extends StatelessWidget {
  const _EmailCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.email),
            title: Text(state.email),
          ),
        );
      },
    );
  }
}
