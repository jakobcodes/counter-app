import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:testapp/constants/enums.dart';
import 'package:testapp/data/models/user.dart';
import 'package:testapp/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequest>(_onLogoutRequested);

    _userSubscription = _authenticationRepository.user
        .listen((user) => add(AppUserChanged(user)));
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  // @override
  // Stream<AppState> mapEventToState(AppEvent event) async* {
  //   if (event is AppUserChanged) {
  //     yield _mapUserChangedToState(event, state);
  //   } else if (event is AppLogoutRequest) {
  //     await _authenticationRepository.logOut();
  //   }
  // }

  // AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
  //   return event.user.isNotEmpty
  //       ? AppState.authenticated(event.user)
  //       : const AppState.unauthenticated();
  // }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequest event, Emitter<AppState> emit){
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
