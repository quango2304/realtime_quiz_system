//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuizResponse {
  /// Returns a new [QuizResponse] instance.
  QuizResponse({
    this.quizId,
    this.title,
    this.createdAt,
    this.questions = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? quizId;

  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  List<QuestionResponse>? questions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is QuizResponse &&
    other.quizId == quizId &&
    other.title == title &&
    other.createdAt == createdAt &&
    _deepEquality.equals(other.questions, questions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (quizId == null ? 0 : quizId!.hashCode) +
    (title == null ? 0 : title!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (questions == null ? 0 : questions!.hashCode);

  @override
  String toString() => 'QuizResponse[quizId=$quizId, title=$title, createdAt=$createdAt, questions=$questions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.quizId != null) {
      json[r'quizId'] = this.quizId;
    } else {
      json[r'quizId'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
    if (this.questions != null) {
      json[r'questions'] = this.questions;
    } else {
      json[r'questions'] = null;
    }
    return json;
  }

  /// Returns a new [QuizResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static QuizResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "QuizResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "QuizResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return QuizResponse(
        quizId: mapValueOfType<int>(json, r'quizId'),
        title: mapValueOfType<String>(json, r'title'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        questions: QuestionResponse.listFromJson(json[r'questions']),
      );
    }
    return null;
  }

  static List<QuizResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <QuizResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = QuizResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, QuizResponse> mapFromJson(dynamic json) {
    final map = <String, QuizResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = QuizResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of QuizResponse-objects as value to a dart map
  static Map<String, List<QuizResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<QuizResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = QuizResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

