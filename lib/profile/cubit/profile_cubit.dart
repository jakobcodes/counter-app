import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testapp/data/models/user.dart';
import 'package:testapp/data/repositories/authentication_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._authenticationRepository)
      : super(ProfileState(
          username: _authenticationRepository.getCurrentDisplayName().toString(),
          email: _authenticationRepository.getCurrentEmail().toString(),
        ));

  final AuthenticationRepository _authenticationRepository;


}
