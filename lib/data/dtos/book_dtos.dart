import 'package:json_annotation/json_annotation.dart';

part 'book_dtos.g.dart';

/// Основной ответ от API
@JsonSerializable(createToJson: false)
class SearchBooksResponseDto {
  final int available;
  final int number;
  final int offset;

  @JsonKey(name: 'books')
  final List<List<BookDto>> bookItems;

  SearchBooksResponseDto({
    required this.available,
    required this.number,
    required this.offset,
    required this.bookItems,
  });

  factory SearchBooksResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchBooksResponseDtoFromJson(json);
}

/// Одна книга
@JsonSerializable(createToJson: false)
class BookDto {
  final int id;
  final String title;
  final String? image;

  @JsonKey(name: 'authors')
  final List<AuthorDto> authors;

  @JsonKey(name: 'rating')
  final RatingDto? rating;

  BookDto({
    required this.id,
    required this.title,
    this.image,
    required this.authors,
    this.rating,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) =>
      _$BookDtoFromJson(json);
}

/// Автор книги
@JsonSerializable(createToJson: false)
class AuthorDto {
  final int id;
  final String name;

  AuthorDto({required this.id, required this.name});

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);
}

/// Рейтинг книги
@JsonSerializable(createToJson: false)
class RatingDto {
  final double average;

  RatingDto({required this.average});

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      _$RatingDtoFromJson(json);
}
