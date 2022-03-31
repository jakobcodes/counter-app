import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:testapp/app/app.dart';
import 'package:testapp/data/repositories/authentication_repository.dart';
import 'package:testapp/internet_connection/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/counter/counter.dart';
import 'package:flow_builder/flow_builder.dart';

class App extends StatelessWidget {
  const App(
      {Key? key,
      required this.connectivity,
      required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(key: key);

  final Connectivity connectivity;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
          BlocProvider(
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider(
            create: (context) =>
                CounterCubit(internetCubit: context.read<InternetCubit>()),
          )
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF202020)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF000000),
          ),
        ),
        // localizationsDelegates: const [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        // ],
        // supportedLocales: AppLocalizations.supportedLocales,
        home: FlowBuilder(
          onGeneratePages: onGenerateAppViewPages,
          state: context.select((AppBloc bloc) => bloc.state.status),
        ));
  }
}
