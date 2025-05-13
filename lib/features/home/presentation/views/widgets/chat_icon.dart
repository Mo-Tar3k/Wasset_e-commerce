import 'package:e_commerce/features/chatbot/presentation/widgets/chatbot_dialog.dart';
import 'package:flutter/material.dart';

class ChatIcon extends StatelessWidget {
  const ChatIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => const ChatbotDialog());
        },
        backgroundColor:
            Colors.transparent, // Transparent to show custom design
        elevation: 0, // Remove default shadow
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.smart_toy, // Robot icon to represent chatbot
            color: Colors.white,
            size: 30, // Slightly larger icon for better visibility
          ),
        ),
      ),
    );
  }
}
