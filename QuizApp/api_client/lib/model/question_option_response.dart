//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuestionOptionResponse {
  /// Returns a new [QuestionOptionResponse] instance.
  QuestionOptionResponse({
    this.id,
    this.text,
    this.questionId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  String? text;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? questionId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is QuestionOptionResponse &&
    other.id == id &&
    other.text == text &&
    other.questionId == questionId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (text == null ? 0 : text!.hashCode) +
    (questionId == null ? 0 : questionId!.hashCode);

  @override
  String toString() => 'QuestionOptionResponse[id=$id, text=$text, questionId=$questionId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.text != null) {
      json[r'text'] = this.text;
    } else {
      json[r'text'] = null;
    }
    if (this.questionId != null) {
      json[r'questionId'] = this.questionId;
    } else {
      json[r'questionId'] = null;
    }
    return json;
  }

  /// Returns a new [QuestionOptionResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static QuestionOptionResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "QuestionOptionResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "QuestionOptionResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return QuestionOptionResponse(
        id: mapValueOfType<String>(json, r'id'),
        text: mapValueOfType<String>(json, r'text'),
        questionId: mapValueOfType<String>(json, r'questionId'),
      );
    }
    return null;
  }

  static List<QuestionOptionResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <QuestionOptionResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = QuestionOptionResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, QuestionOptionResponse> mapFromJson(dynamic json) {
    final map = <String, QuestionOptionResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = QuestionOptionResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of QuestionOptionResponse-objects as value to a dart map
  static Map<String, List<QuestionOptionResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<QuestionOptionResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = QuestionOptionResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

