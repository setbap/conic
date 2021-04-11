part of 'latest_news_cubit.dart';

@immutable
class LatestNewsState {
  final List<NewsItem> data;
  final bool isLoading;
  final bool isError;
  final String error;

  const LatestNewsState({
    required this.data,
    required this.isLoading,
    required this.error,
    this.isError = false,
  });

  LatestNewsState copyWith({
    List<NewsItem>? data,
    bool? isLoading,
    bool? isError,
    String? error,
  }) {
    return LatestNewsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LatestNewsState &&
        listEquals(other.data, data) &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ isLoading.hashCode ^ error.hashCode;
}
