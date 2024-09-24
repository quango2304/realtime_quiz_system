//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class QuizApiClient {
  QuizApiClient([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create a new quiz
  ///
  /// Creates a new quiz with questions and returns the quiz details.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [NewQuizRequest] newQuizRequest (required):
  Future<Response> createQuizWithHttpInfo(NewQuizRequest newQuizRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/quizzes';

    // ignore: prefer_final_locals
    Object? postBody = newQuizRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create a new quiz
  ///
  /// Creates a new quiz with questions and returns the quiz details.
  ///
  /// Parameters:
  ///
  /// * [NewQuizRequest] newQuizRequest (required):
  Future<QuizResponse?> createQuiz(NewQuizRequest newQuizRequest,) async {
    final response = await createQuizWithHttpInfo(newQuizRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'QuizResponse',) as QuizResponse;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /quizzes/{quizId}/start' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] quizId (required):
  Future<Response> quizzesQuizIdStartPostWithHttpInfo(int quizId,) async {
    // ignore: prefer_const_declarations
    final path = r'/quizzes/{quizId}/start'
      .replaceAll('{quizId}', quizId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] quizId (required):
  Future<void> quizzesQuizIdStartPost(int quizId,) async {
    final response = await quizzesQuizIdStartPostWithHttpInfo(quizId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Performs an HTTP 'POST /quizzes/{quizId}/submit-answer' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] quizId (required):
  ///
  /// * [AnswerRequest] answerRequest (required):
  Future<Response> submitAnswerWithHttpInfo(int quizId, AnswerRequest answerRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/quizzes/{quizId}/submit-answer'
      .replaceAll('{quizId}', quizId.toString());

    // ignore: prefer_final_locals
    Object? postBody = answerRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] quizId (required):
  ///
  /// * [AnswerRequest] answerRequest (required):
  Future<void> submitAnswer(int quizId, AnswerRequest answerRequest,) async {
    final response = await submitAnswerWithHttpInfo(quizId, answerRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
