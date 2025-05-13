part of 'chatbot_cubit.dart';

abstract class ChatbotState {}

class ChatbotInitial extends ChatbotState {}

class ChatbotLoading extends ChatbotState {}

class ChatbotLoaded extends ChatbotState {
  final List<String> messages;
  final List<String> messageSenders;

  ChatbotLoaded(this.messages, List<String>? messageSenders)
    : messageSenders = messageSenders ?? []; // Ensure non-null list
}

class ChatbotError extends ChatbotState {
  final String error;

  ChatbotError(this.error);
}
