import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:e_commerce/core/services/user_local_service.dart';

class EmailService {
  static Future<bool> sendContactEmail({
    required String subject,
    required String message,
    required String time,
  }) async {
    try {
      final user = await UserLocalService.loadUser();
      final email = user?.email ?? '';
      final name = user?.name ?? 'Guest';

      print('\x1B[32m👤 User name: $name\x1B[0m');
      print('\x1B[32m📧 User email: $email\x1B[0m');

      if (email.isEmpty) {
        print('\x1B[31m❌ User email is empty!\x1B[0m');
        return false;
      }

      final templateParams = {
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'time': time,
      };

      print('\x1B[32m📦 Params being sent: $templateParams\x1B[0m');

      await emailjs.send(
        'service_mbe6zb6',
        'template_pbybq35',
        templateParams,
        const emailjs.Options(
          publicKey: 'VTTWim-wnPYIn9RWQ',
          privateKey: 'zSMff775bdaK4bHBrg731',
        ),
      );

      print('\x1B[32m✅ Email sent successfully!\x1B[0m');
      return true;
    } catch (error) {
      print('\x1B[31m❌ Email sending failed: $error\x1B[0m');
      return false;
    }
  }
}
