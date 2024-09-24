# Project Structure

This is the Quiz app which support creating quiz, join quiz session, realtime leader board, the code follows the Domain-Driven Design (DDD) principles to organize the codebase.

## Root Directory
- **test/**: unit test
- **api_client/**: generated API client code from the server swagger json file.
- **swagger.json**: server swagger json fil
- **gen_api.sh**: script to download swagger file then generate the api client lib

## Source code folder

### lib/
- **domain/**: repository interface and model
- **application/**: just cubits
- **infrastructure/**: implementation for the repo
- **presentation/**: screens and widgets.