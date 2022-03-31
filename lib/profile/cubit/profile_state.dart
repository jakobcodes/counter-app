part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.username, required this.email});

  final String username;

  final String email;

  @override
  List<Object> get props => [username, email];

  ProfileState copyWith({
    String? username,
    String? email,
  }) {
    return ProfileState(
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }
}
