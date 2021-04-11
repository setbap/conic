part of 'latest_news_cubit.dart';

@immutable
class LatestNewsState {
  final List<NewsItem> data;
  final bool loading;
  final String error;

  LatestNewsState({
    required this.data,
    required this.loading,
    required this.error,
  });

  LatestNewsState copyWith({
    List<NewsItem>? data,
    bool? loading,
    String? error,
  }) {
    return LatestNewsState(
      data: data ?? this.data,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatestNewsState &&
        listEquals(other.data, data) &&
        other.loading == loading &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ loading.hashCode ^ error.hashCode;
}
