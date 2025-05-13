import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://89db-102-189-85-35.ngrok-free.app"; // تأكد من صحة الـ URL

  Future<Map<String, dynamic>> startConversation() async {
    try {
      final response = await _dio.post("$_baseUrl/start_conversation");
      if (response.data != null) {
        return response.data;
      } else {
        print("Empty response from server");
        throw Exception("Empty response from server");
      }
    } on DioError catch (dioError) {
      print("DioError in startConversation: ${dioError.message}");
      print("DioError details: ${dioError.response?.data}");
      throw Exception("Network error: ${dioError.message}");
    } catch (e) {
      print("Error in startConversation: $e");
      throw Exception("Failed to start conversation: $e");
    }
  }

  Future<Map<String, dynamic>> askQuestion(String question) async {
    try {
      final response = await _dio.post(
        "$_baseUrl/ask",
        data: {"question": question},
      );
      if (response.data != null) {
        return response.data;
      } else {
        print("Empty response from server");
        throw Exception("Empty response from server");
      }
    } on DioError catch (dioError) {
      print("DioError in askQuestion: ${dioError.message}");
      print("DioError details: ${dioError.response?.data}");
      throw Exception("Network error: ${dioError.message}");
    } catch (e) {
      print("Error in askQuestion: $e");
      throw Exception("Failed to send question: $e");
    }
  }
}
