// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBooksResponseDto _$SearchBooksResponseDtoFromJson(
  Map<String, dynamic> json,
) => SearchBooksResponseDto(
  available: (json['available'] as num).toInt(),
  number: (json['number'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
  bookItems: (json['books'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>)
            .map((e) => BookDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      )
      .toList(),
);

BookDto _$BookDtoFromJson(Map<String, dynamic> json) => BookDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  image: json['image'] as String?,
  authors: (json['authors'] as List<dynamic>)
      .map((e) => AuthorDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  rating: json['rating'] == null
      ? null
      : RatingDto.fromJson(json['rating'] as Map<String, dynamic>),
);

AuthorDto _$AuthorDtoFromJson(Map<String, dynamic> json) =>
    AuthorDto(id: (json['id'] as num).toInt(), name: json['name'] as String);

RatingDto _$RatingDtoFromJson(Map<String, dynamic> json) =>
    RatingDto(average: (json['average'] as num).toDouble());
