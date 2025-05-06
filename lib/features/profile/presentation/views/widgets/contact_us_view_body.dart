import 'package:e_commerce/core/widgets/build_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:e_commerce/core/services/api_contact_form.dart';

class ContactUsViewBody extends StatefulWidget {
  const ContactUsViewBody({super.key});

  @override
  State<ContactUsViewBody> createState() => _ContactUsViewBodyState();
}

class _ContactUsViewBodyState extends State<ContactUsViewBody> {
  final _formKey = GlobalKey<FormState>();
  final subjectCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> send() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final now = DateFormat.yMd().add_jm().format(DateTime.now());
      final success = await EmailService.sendContactEmail(
        subject: subjectCtrl.text,
        message: messageCtrl.text,
        time: now,
      );

      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? '✅ Message sent!' : '❌ Failed to send.'),
            backgroundColor: success ? Colors.green : Colors.red,
            behavior: SnackBarBehavior.floating, // ✅ بشكل عائم
          ),
        );

        if (success) {
          await Future.delayed(
            const Duration(milliseconds: 500),
          ); // ⏳ انتظار قصير
          Navigator.pop(context); // ✅ يرجع للصفحة السابقة (Profile مثلاً)
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Contact Us',
        showNotification: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDEFEF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                _buildCardTextField(controller: subjectCtrl, label: 'Subject'),
                const SizedBox(height: 16),
                _buildCardTextField(
                  controller: messageCtrl,
                  label: 'Message',
                  maxLines: 4,
                ),
                const SizedBox(height: 32),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                      onPressed: send,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
      ),
    );
  }
}
