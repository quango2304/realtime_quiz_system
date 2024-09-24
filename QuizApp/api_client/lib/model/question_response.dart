//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuestionResponse {
  /// Returns a new [QuestionResponse] instance.
  QuestionResponse({
    this.questionId,
    this.text,
    this.order,
    this.quizId,
    this.options = const [],
    this.maxPoint,
    this.type,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? questionId;

  String? text;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? order;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? quizId;

  List<QuestionOptionResponse>? options;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? maxPoint;

  String? type;

  @override
  bool operator ==(Object other) => identical(this, other) || other is QuestionResponse &&
    other.questionId == questionId &&
    other.text == text &&
    other.order == order &&
    other.quizId == quizId &&
    _deepEquality.equals(other.options, options) &&
    other.maxPoint == maxPoint &&
    other.type == type;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (questionId == null ? 0 : questionId!.hashCode) +
    (text == null ? 0 : text!.hashCode) +
    (order == null ? 0 : order!.hashCode) +
    (quizId == null ? 0 : quizId!.hashCode) +
    (options == null ? 0 : options!.hashCode) +
    (maxPoint == null ? 0 : maxPoint!.hashCode) +
    (type == null ? 0 : type!.hashCode);

  @override
  String toString() => 'QuestionResponse[questionId=$questionId, text=$text, order=$order, quizId=$quizId, options=$options, maxPoint=$maxPoint, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.questionId != null) {
      json[r'questionId'] = this.questionId;
    } else {
      json[r'questionId'] = null;
    }
    if (this.text != null) {
      json[r'text'] = this.text;
    } else {
      json[r'text'] = null;
    }
    if (this.order != null) {
      json[r'order'] = this.order;
    } else {
      json[r'order'] = null;
    }
    if (this.quizId != null) {
      json[r'quizId'] = this.quizId;
    } else {
      json[r'quizId'] = null;
    }
    if (this.options != null) {
      json[r'options'] = this.options;
    } else {
      json[r'options'] = null;
    }
    if (this.maxPoint != null) {
      json[r'maxPoint'] = this.maxPoint;
    } else {
      json[r'maxPoint'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    return json;
  }

  /// Returns a new [QuestionResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static QuestionResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "QuestionResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "QuestionResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return QuestionResponse(
        questionId: mapValueOfType<String>(json, r'questionId'),
        text: mapValueOfType<String>(json, r'text'),
        order: mapValueOfType<int>(json, r'order'),
        quizId: mapValueOfType<int>(json, r'quizId'),
        options: QuestionOptionResponse.listFromJson(json[r'options']),
        maxPoint: mapValueOfType<int>(json, r'maxPoint'),
        type: mapValueOfType<String>(json, r'type'),
      );
    }
    return null;
  }

  static List<QuestionResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <QuestionResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = QuestionResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, QuestionResponse> mapFromJson(dynamic json) {
    final map = <String, QuestionResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = QuestionResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of QuestionResponse-objects as value to a dart map
  static Map<String, List<QuestionResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<QuestionResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = QuestionResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

