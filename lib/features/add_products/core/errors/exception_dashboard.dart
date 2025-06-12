class CustomExceptionDashboard implements Exception {
  final String message;

  CustomExceptionDashboard(String s, {required this.message});

  @override
  String toString() {
    return message;
  }
}
