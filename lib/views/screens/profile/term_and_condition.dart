import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import '../../cubits/home_cubit.dart';
import '../../widgets/widgets.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Terms and condition',
      onBackTap: () {
        context.go('/home');
        context.read<HomeCubit>().changeNavBar(HomeNavBar.home);
      },
      useBackButton: true,
      body: SingleChildScrollView(
        child: Html(
          data: '''
        <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Terms and Conditions - Team Sphere</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 20px;
      padding: 0;
    }
    h1, h2 {
      color: #2c3e50;
    }
    a {
      color: #2980b9;
      text-decoration: none;
    }
    ul {
      margin: 10px 0;
      padding-left: 20px;
    }
    .container {
      max-width: 800px;
      margin: 0 auto;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Terms and Conditions</h1>
    <p>Welcome to Team Sphere! By accessing or using our application, you are agreeing to abide by the terms and conditions outlined here. Please read them carefully. If you disagree with any part of these terms, you must refrain from using Team Sphere. These terms apply to all users, whether registered or unregistered, and govern your use of all features and services offered within the application. Failure to adhere to these terms may result in suspension or termination of your access to Team Sphere. We are committed to creating a safe and efficient platform, and your compliance is essential to achieving this goal.</p>

    <h2>1. Acceptance of Terms</h2>
    <p>By using the Team Sphere application, you indicate your full acceptance of these terms and conditions. This agreement is legally binding, and by accessing the application, you agree to comply with all applicable rules and policies. If you do not agree with these terms, you are prohibited from accessing or using the application in any way. These terms serve to protect both you as a user and us as the service provider, ensuring a secure and fair environment for all. Your continued use of Team Sphere signifies your acknowledgment and acceptance of these terms.</p>

    <h2>2. Changes to Terms</h2>
    <p>We reserve the right to update or modify these Terms and Conditions at any time without prior notice. Changes will become effective immediately upon being posted within the application. It is your responsibility to review these terms regularly to stay informed of any updates. Continued use of Team Sphere following any changes constitutes your acceptance of the revised terms. We encourage users to bookmark this page and check for updates periodically. By staying informed, you help ensure your experience remains compliant and uninterrupted as we evolve and improve our services.</p>

    <h2>3. User Responsibilities</h2>
    <p>As a user of Team Sphere, you are responsible for maintaining the integrity of your account. This includes keeping your login credentials confidential and ensuring that all information you provide during registration or use of the application is accurate and up-to-date. You agree to use the application only for lawful purposes and refrain from engaging in any activities that may disrupt the service or harm other users. Any misuse of the platform, including unauthorized access, sharing of malicious content, or violation of applicable laws, may result in suspension or termination of your account.</p>

    <h2>4. Intellectual Property</h2>
    <p>All intellectual property within Team Sphere, including but not limited to text, graphics, designs, and code, is owned exclusively by Team Sphere or its licensors. These materials are protected under copyright, trademark, and other applicable laws. Unauthorized reproduction, distribution, or use of any content is strictly prohibited and may result in legal action. Users are granted a limited, non-transferable license to use the application solely for its intended purpose. Any attempt to reverse-engineer, decompile, or otherwise exploit the platform’s features is a violation of these terms.</p>

    <h2>5. Limitation of Liability</h2>
    <p>Team Sphere shall not be held liable for any damages resulting from your use of the application. This includes, but is not limited to, data loss, service interruptions, or unauthorized access to your account. While we strive to maintain a secure and reliable platform, no system is immune to risks. Users are encouraged to implement their own security measures, such as strong passwords and updated software, to further protect their accounts. By using Team Sphere, you acknowledge and accept that the service is provided "as is" without any express or implied warranties.</p>

    <h2>6. Termination</h2>
    <p>We reserve the right to suspend or terminate your access to Team Sphere at any time, with or without notice, for any reason, including but not limited to violation of these Terms and Conditions. Upon termination, your right to use the application will cease immediately. You may also terminate your account at any time by contacting us directly. Any data associated with your account may be deleted following termination. It is your responsibility to back up any important information before requesting account termination or upon being notified of suspension.</p>

    <h2>7. Governing Law</h2>
    <p>These Terms and Conditions are governed by and construed in accordance with the laws of [Your Country/Region]. Any disputes arising from the use of Team Sphere will be subject to the exclusive jurisdiction of the courts located in [Your Country/Region]. By agreeing to these terms, you consent to resolve any legal matters in accordance with these specified laws. This section ensures clarity and consistency in handling disputes, providing both users and the service provider with a structured framework for conflict resolution.</p>

    <h2>8. Contact Us</h2>
    <p>If you have any questions, concerns, or feedback regarding these Terms and Conditions, please do not hesitate to reach out to us. You can contact our support team at <a href="mailto:support@teamsphere.com">support@teamsphere.com</a>. We are committed to providing a transparent and user-friendly experience, and your input helps us improve our services. Our team is available during business hours to assist with any issues or inquiries. Thank you for using Team Sphere!</p>

    <p>Thank you for choosing Team Sphere. We value your participation and look forward to serving you!</p>
  </div>
</body>
</html>
        ''',
        ),
      ),
    );
  }
}
