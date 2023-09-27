part of 'add_bloc.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

final class AddLoading extends AddState {}

final class AddLoaded extends AddState {}
