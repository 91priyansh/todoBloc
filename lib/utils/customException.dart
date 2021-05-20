class CustomException implements Exception {
  final String errorMessage;

  CustomException({this.errorMessage});

  @override
  String toString() {
    return errorMessage ?? "Something went wrong!";
  }
}
