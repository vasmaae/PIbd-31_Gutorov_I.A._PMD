// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LikeStateCWProxy {
  LikeState likedIds(List<int>? likedIds);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LikeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LikeState(...).copyWith(id: 12, name: "My name")
  /// ```
  LikeState call({List<int>? likedIds});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLikeState.copyWith(...)` or call `instanceOfLikeState.copyWith.fieldName(value)` for a single field.
class _$LikeStateCWProxyImpl implements _$LikeStateCWProxy {
  const _$LikeStateCWProxyImpl(this._value);

  final LikeState _value;

  @override
  LikeState likedIds(List<int>? likedIds) => call(likedIds: likedIds);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LikeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LikeState(...).copyWith(id: 12, name: "My name")
  /// ```
  LikeState call({Object? likedIds = const $CopyWithPlaceholder()}) {
    return LikeState(
      likedIds: likedIds == const $CopyWithPlaceholder()
          ? _value.likedIds
          // ignore: cast_nullable_to_non_nullable
          : likedIds as List<int>?,
    );
  }
}

extension $LikeStateCopyWith on LikeState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLikeState.copyWith(...)` or `instanceOfLikeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LikeStateCWProxy get copyWith => _$LikeStateCWProxyImpl(this);
}
