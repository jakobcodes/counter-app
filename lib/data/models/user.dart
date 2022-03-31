import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {

  const User({this.email, required this.id, this.username});

  final String? email;

  final String id;

  final String? username;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, username];

}
