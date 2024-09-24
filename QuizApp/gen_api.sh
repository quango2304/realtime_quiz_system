curl -k -o swagger.json http://localhost:5045/swagger/v1/swagger.json
openapi-generator generate -i swagger.json -g dart -o api_client --api-name-suffix "ApiClient"