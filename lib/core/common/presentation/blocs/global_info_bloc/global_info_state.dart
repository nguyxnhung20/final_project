part of 'global_info_bloc.dart';

class GlobalInfoState extends Equatable {
  final StatusState status;
  final List<Genre>? genreList;
  final ImageConfigInfo? imageConfigInfo;
  final Locale? currentLocale;
  final String? errMsg;
  const GlobalInfoState({
    this.genreList,
    this.imageConfigInfo,
    this.errMsg,
    this.currentLocale,
    this.status = StatusState.idle,
  });

  @override
  List<Object?> get props => [
        status,
        genreList,
        imageConfigInfo,
        errMsg,
        currentLocale,
      ];

  GlobalInfoState copyWith({
    StatusState? status,
    List<Genre>? genreList,
    ImageConfigInfo? imageConfigInfo,
    String? errMsg,
    Locale? currentLocale,
  }) {
    return GlobalInfoState(
      status: status ?? this.status,
      genreList: genreList ?? this.genreList,
      imageConfigInfo: imageConfigInfo ?? this.imageConfigInfo,
      errMsg: errMsg,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
}
