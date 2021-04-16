part of 'index_page_data_cubit.dart';

@immutable
class IndexPageDataState {
  final IndexPageDataModel? data;
  final bool isLoading;
  final bool isError;
  final String error;

  const IndexPageDataState({
    this.data,
    required this.isLoading,
    required this.error,
    this.isError = false,
  });

  IndexPageDataState copyWith({
    IndexPageDataModel? data,
    bool? isLoading,
    bool? isError,
    String? error,
  }) {
    return IndexPageDataState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IndexPageDataState &&
        other.data == data &&
        other.isLoading == isLoading &&
        other.isError == isError &&
        other.error == error;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        isLoading.hashCode ^
        isError.hashCode ^
        error.hashCode;
  }
}
