class CustomException implements Exception {
  final String message;

  CustomException(String s, {required this.message});

  @override
  String toString() {
    return message;
  }
}
