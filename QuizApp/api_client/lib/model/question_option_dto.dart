//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuestionOptionDto {
  /// Returns a new [QuestionOptionDto] instance.
  QuestionOptionDto({
    this.text,
    this.isCorrect,
  });

  String? text;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isCorrect;

  @override
  bool operator ==(Object other) => identical(this, other) || other is QuestionOptionDto &&
    other.text == text &&
    other.isCorrect == isCorrect;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (text == null ? 0 : text!.hashCode) +
    (isCorrect == null ? 0 : isCorrect!.hashCode);

  @override
  String toString() => 'QuestionOptionDto[text=$text, isCorrect=$isCorrect]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.text != null) {
      json[r'text'] = this.text;
    } else {
      json[r'text'] = null;
    }
    if (this.isCorrect != null) {
      json[r'isCorrect'] = this.isCorrect;
    } else {
      json[r'isCorrect'] = null;
    }
    return json;
  }

  /// Returns a new [QuestionOptionDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static QuestionOptionDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "QuestionOptionDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "QuestionOptionDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return QuestionOptionDto(
        text: mapValueOfType<String>(json, r'text'),
        isCorrect: mapValueOfType<bool>(json, r'isCorrect'),
      );
    }
    return null;
  }

  static List<QuestionOptionDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <QuestionOptionDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = QuestionOptionDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, QuestionOptionDto> mapFromJson(dynamic json) {
    final map = <String, QuestionOptionDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = QuestionOptionDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of QuestionOptionDto-objects as value to a dart map
  static Map<String, List<QuestionOptionDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<QuestionOptionDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = QuestionOptionDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

