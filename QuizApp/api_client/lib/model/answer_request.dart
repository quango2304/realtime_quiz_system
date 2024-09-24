//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AnswerRequest {
  /// Returns a new [AnswerRequest] instance.
  AnswerRequest({
    this.questionId,
    this.userId,
    this.selectedOptions = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? questionId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userId;

  List<String>? selectedOptions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AnswerRequest &&
    other.questionId == questionId &&
    other.userId == userId &&
    _deepEquality.equals(other.selectedOptions, selectedOptions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (questionId == null ? 0 : questionId!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (selectedOptions == null ? 0 : selectedOptions!.hashCode);

  @override
  String toString() => 'AnswerRequest[questionId=$questionId, userId=$userId, selectedOptions=$selectedOptions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.questionId != null) {
      json[r'questionId'] = this.questionId;
    } else {
      json[r'questionId'] = null;
    }
    if (this.userId != null) {
      json[r'userId'] = this.userId;
    } else {
      json[r'userId'] = null;
    }
    if (this.selectedOptions != null) {
      json[r'selectedOptions'] = this.selectedOptions;
    } else {
      json[r'selectedOptions'] = null;
    }
    return json;
  }

  /// Returns a new [AnswerRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AnswerRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AnswerRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AnswerRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AnswerRequest(
        questionId: mapValueOfType<String>(json, r'questionId'),
        userId: mapValueOfType<String>(json, r'userId'),
        selectedOptions: json[r'selectedOptions'] is Iterable
            ? (json[r'selectedOptions'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<AnswerRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AnswerRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AnswerRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AnswerRequest> mapFromJson(dynamic json) {
    final map = <String, AnswerRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AnswerRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AnswerRequest-objects as value to a dart map
  static Map<String, List<AnswerRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AnswerRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AnswerRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

