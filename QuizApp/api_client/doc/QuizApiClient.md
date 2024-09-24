# openapi.api.QuizApiClient

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createQuiz**](QuizApiClient.md#createquiz) | **POST** /quizzes | Create a new quiz
[**quizzesQuizIdStartPost**](QuizApiClient.md#quizzesquizidstartpost) | **POST** /quizzes/{quizId}/start | 
[**submitAnswer**](QuizApiClient.md#submitanswer) | **POST** /quizzes/{quizId}/submit-answer | 


# **createQuiz**
> QuizResponse createQuiz(newQuizRequest)

Create a new quiz

Creates a new quiz with questions and returns the quiz details.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = QuizApiClient();
final newQuizRequest = NewQuizRequest(); // NewQuizRequest | 

try {
    final result = api_instance.createQuiz(newQuizRequest);
    print(result);
} catch (e) {
    print('Exception when calling QuizApiClient->createQuiz: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newQuizRequest** | [**NewQuizRequest**](NewQuizRequest.md)|  | 

### Return type

[**QuizResponse**](QuizResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **quizzesQuizIdStartPost**
> quizzesQuizIdStartPost(quizId)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = QuizApiClient();
final quizId = 56; // int | 

try {
    api_instance.quizzesQuizIdStartPost(quizId);
} catch (e) {
    print('Exception when calling QuizApiClient->quizzesQuizIdStartPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **quizId** | **int**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitAnswer**
> submitAnswer(quizId, answerRequest)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = QuizApiClient();
final quizId = 56; // int | 
final answerRequest = AnswerRequest(); // AnswerRequest | 

try {
    api_instance.submitAnswer(quizId, answerRequest);
} catch (e) {
    print('Exception when calling QuizApiClient->submitAnswer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **quizId** | **int**|  | 
 **answerRequest** | [**AnswerRequest**](AnswerRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

