import 'package:testapp/app/app.dart';
import 'package:testapp/internet_connection/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/counter/counter.dart';
import 'package:testapp/constants/enums.dart';
import 'package:testapp/profile/view/profile_page.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CounterPage());

  @override
  Widget build(BuildContext context) {
    return const CounterView();
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push<void>(ProfilePage.route());
            },
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutRequest());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;

              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Wifi) {
                return Text('Counter: ${counterState}Internet: Wifi');
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Mobile) {
                return Text('Counter: ${counterState}Internet: Mobile');
              } else {
                return Text('Counter: ${counterState}Internet: Disconnected');
              }
            }),
            const CounterText(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final counterValue =
        context.select((CounterCubit cubit) => cubit.state.counterValue);
    return Text('$counterValue', style: theme.textTheme.headline1);
  }
}
