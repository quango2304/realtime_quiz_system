# openapi.api.UserApiClient

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UserApiClient.md#createuser) | **POST** /users | Create a new user


# **createUser**
> UserResponse createUser(newUserRequest)

Create a new user

Creates a new user and returns the user details.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = UserApiClient();
final newUserRequest = NewUserRequest(); // NewUserRequest | 

try {
    final result = api_instance.createUser(newUserRequest);
    print(result);
} catch (e) {
    print('Exception when calling UserApiClient->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newUserRequest** | [**NewUserRequest**](NewUserRequest.md)|  | 

### Return type

[**UserResponse**](UserResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

