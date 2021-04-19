import 'package:flutter/foundation.dart';

@immutable
class GenericPageStete<T> {
  final T? data;
  final bool isLoading;
  final bool isError;
  final String error;

  const GenericPageStete({
    this.data,
    required this.isLoading,
    required this.error,
    this.isError = false,
  });

  GenericPageStete<T> copyWith({
    T? data,
    bool? isLoading,
    bool? isError,
    String? error,
  }) {
    return GenericPageStete<T>(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenericPageStete<T> &&
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

  @override
  String toString() {
    return 'GenericPageStete(data: $data, isLoading: $isLoading, isError: $isError, error: $error)';
  }
}
