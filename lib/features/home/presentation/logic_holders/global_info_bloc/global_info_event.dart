part of 'global_info_bloc.dart';

class GetGlobalInfo extends GlobalInfoEvent {}

abstract class GlobalInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetSavedLangCode extends GlobalInfoEvent {
  final String langCode;
  SetSavedLangCode({
    required this.langCode,
  });

  @override
  List<Object?> get props => [langCode];
}
