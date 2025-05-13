// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/services/api_chat_service.dart';

part 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final ApiService _apiService;
  final List<String> messages = [];
  final List<String> messageSenders = []; // Tracks the sender of each message

  ChatbotCubit(this._apiService) : super(ChatbotInitial()) {
    if (_apiService == null) {
      print('Error: ApiService is null');
      throw Exception("ApiService is null");
    } else {
      print('ApiService successfully initialized: $_apiService');
    }
  }

  void startConversation() async {
    print('Starting conversation...');
    try {
      final response = await _apiService.startConversation();
      print('Conversation started, response: $response');
      if (response != null) {
        messages.add(response["message"]);
        messageSenders.add("bot"); // Add bot as the sender
        if (response.containsKey("context")) {
          messages.addAll(response["context"].cast<String>());
          messageSenders.addAll(
            List.filled(response["context"].length, "bot"),
          ); // Add bot as the sender for context
        }
        emit(ChatbotLoaded(messages, messageSenders));
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      print("Error in startConversation: $e");
      emit(ChatbotError("Failed to start conversation."));
    }
  }

  Future<void> sendMessage(String question) async {
    try {
      messages.add("You: $question");
      messageSenders.add("user"); // Add user as the sender
      final response = await _apiService.askQuestion(question);
      if (response != null && response.containsKey("answer")) {
        messages.add("Bot: ${response["answer"]}");
        messageSenders.add("bot"); // Add bot as the sender
        if (response.containsKey("context")) {
          messages.addAll(response["context"].cast<String>());
          messageSenders.addAll(
            List.filled(response["context"].length, "bot"),
          ); // Add bot as the sender for context
        }
        emit(ChatbotLoaded(List.from(messages), List.from(messageSenders)));
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      print("Error in sendMessage: $e");
      emit(ChatbotError("Failed to send message."));
    }
  }
}
