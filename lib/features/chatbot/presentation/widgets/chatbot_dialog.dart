import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/services/api_chat_service.dart';
import 'package:e_commerce/features/chatbot/presentation/cubits/chatbot_cubit.dart';

class ChatbotDialog extends StatelessWidget {
  const ChatbotDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: Colors.white,
      child: BlocProvider(
        create: (_) {
          final apiService = ApiService();
          return ChatbotCubit(apiService);
        },
        child: ChatbotContent(),
      ),
    );
  }
}

class ChatbotContent extends StatefulWidget {
  @override
  _ChatbotContentState createState() => _ChatbotContentState();
}

class _ChatbotContentState extends State<ChatbotContent> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(); // Scroll controller
  bool _isLoading = false; // Track loading state

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title for the chatbot
          Text(
            "Chatbot",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<ChatbotCubit, ChatbotState>(
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom(); // Scroll to the bottom when messages update
                });

                if (state is ChatbotLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatbotLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final isUserMessage =
                          state.messageSenders[index] ==
                          "user"; // Determine sender
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment:
                              isUserMessage
                                  ? Alignment
                                      .centerRight // User messages aligned to the right
                                  : Alignment
                                      .centerLeft, // Bot messages aligned to the left
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 14,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isUserMessage
                                      ? Colors
                                          .grey[300] // User messages in light gray
                                      : Color(
                                        0xFFFFE0E0,
                                      ), // Bot messages in light red
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              state.messages[index],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ChatbotError) {
                  return Center(child: Text("Error: ${state.error}"));
                }
                return Center(child: Text("Start a conversation!"));
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.red[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              _isLoading
                  ? SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2,
                    ),
                  )
                  : IconButton(
                    icon: Icon(
                      Icons.send,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    onPressed: () async {
                      final message = _controller.text.trim();
                      if (message.isNotEmpty) {
                        setState(() {
                          _isLoading = true; // Show loading indicator
                        });
                        await context.read<ChatbotCubit>().sendMessage(message);
                        setState(() {
                          _isLoading = false; // Hide loading indicator
                        });
                        _controller.clear();
                      }
                    },
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
