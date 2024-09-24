//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewQuizRequest {
  /// Returns a new [NewQuizRequest] instance.
  NewQuizRequest({
    this.title,
    this.userId,
    this.questions = const [],
  });

  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userId;

  List<QuestionDto>? questions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewQuizRequest &&
    other.title == title &&
    other.userId == userId &&
    _deepEquality.equals(other.questions, questions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (questions == null ? 0 : questions!.hashCode);

  @override
  String toString() => 'NewQuizRequest[title=$title, userId=$userId, questions=$questions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.userId != null) {
      json[r'userId'] = this.userId;
    } else {
      json[r'userId'] = null;
    }
    if (this.questions != null) {
      json[r'questions'] = this.questions;
    } else {
      json[r'questions'] = null;
    }
    return json;
  }

  /// Returns a new [NewQuizRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewQuizRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewQuizRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewQuizRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewQuizRequest(
        title: mapValueOfType<String>(json, r'title'),
        userId: mapValueOfType<String>(json, r'userId'),
        questions: QuestionDto.listFromJson(json[r'questions']),
      );
    }
    return null;
  }

  static List<NewQuizRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewQuizRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewQuizRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewQuizRequest> mapFromJson(dynamic json) {
    final map = <String, NewQuizRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewQuizRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewQuizRequest-objects as value to a dart map
  static Map<String, List<NewQuizRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewQuizRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewQuizRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

