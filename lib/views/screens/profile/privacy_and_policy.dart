import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import '../../cubits/home_cubit.dart';
import '../../widgets/widgets.dart';

class PrivacyAndPolicyScreen extends StatelessWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Privacy and Policy',
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
  <title>Privacy Policy - Team Sphere</title>
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
    <h1>Privacy Policy</h1>
    <p>At Team Sphere, we are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you use our application. By using Team Sphere, you consent to the practices described in this policy. If you do not agree with this Privacy Policy, please do not use the application.</p>

    <h2>1. Information We Collect</h2>
    <p>We collect personal information that you provide to us when you register for an account or use certain features of Team Sphere. The types of information we may collect include:</p>
    <ul>
      <li><strong>Account Information:</strong> Name, email address, username, and other registration details.</li>
      <li><strong>Usage Data:</strong> Information on how you interact with the application, including your preferences, actions, and activity within the platform.</li>
      <li><strong>Device Information:</strong> Information about your device, such as the device type, operating system, IP address, and browser type.</li>
      <li><strong>Payment Information:</strong> If you make a payment, we collect payment details like credit card information through third-party processors.</li>
    </ul>

    <h2>2. How We Use Your Information</h2>
    <p>We use the information we collect to provide, improve, and personalize your experience with Team Sphere. Specifically, we may use your information for the following purposes:</p>
    <ul>
      <li><strong>Account Management:</strong> To manage your account, process registration, and provide customer support.</li>
      <li><strong>Service Improvement:</strong> To enhance our services, including analyzing usage trends and improving the functionality of the application.</li>
      <li><strong>Communication:</strong> To send you notifications, updates, and important information related to your account or Team Sphere.</li>
      <li><strong>Security:</strong> To monitor and protect the security of the application and its users.</li>
    </ul>

    <h2>3. Sharing Your Information</h2>
    <p>We do not share your personal information with third parties except in the following circumstances:</p>
    <ul>
      <li><strong>Service Providers:</strong> We may share your information with trusted third-party service providers who help operate and manage Team Sphere, such as hosting providers or payment processors.</li>
      <li><strong>Legal Compliance:</strong> If required by law, we may disclose your information to comply with legal obligations, such as responding to a subpoena, court order, or legal process.</li>
      <li><strong>Business Transfers:</strong> If we are involved in a merger, acquisition, or sale of assets, your information may be transferred as part of that transaction.</li>
    </ul>

    <h2>4. Data Retention</h2>
    <p>We will retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law. When your information is no longer needed, we will securely delete or anonymize it.</p>

    <h2>5. Your Rights and Choices</h2>
    <p>You have certain rights and choices regarding the collection and use of your personal information:</p>
    <ul>
      <li><strong>Access and Correction:</strong> You may request access to the personal information we hold about you and request that we update or correct any inaccuracies.</li>
      <li><strong>Deletion:</strong> You can request the deletion of your personal information, subject to legal obligations or retention policies.</li>
      <li><strong>Opt-Out:</strong> You can opt-out of receiving promotional communications by following the instructions provided in the communication or contacting us directly.</li>
    </ul>

    <h2>6. Security</h2>
    <p>We take the security of your personal information seriously. We implement reasonable physical, technical, and administrative safeguards to protect your information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission or storage is completely secure, and we cannot guarantee the absolute security of your data.</p>

    <h2>7. International Transfers</h2>
    <p>Your information may be transferred to, stored, or processed in countries outside of your own. By using Team Sphere, you consent to the transfer of your information to other countries, which may have different data protection laws than your country of residence. We will take appropriate measures to ensure that your information is protected in accordance with this Privacy Policy.</p>

    <h2>8. Updates to This Privacy Policy</h2>
    <p>We may update this Privacy Policy from time to time to reflect changes in our practices or applicable laws. Any updates will be posted within the application, and the date of the latest revision will be indicated at the top of the page. We encourage you to review this policy regularly to stay informed about how we are protecting your privacy.</p>

    <h2>9. Contact Us</h2>
    <p>If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at <a href="mailto:support@teamsphere.com">support@teamsphere.com</a>.</p>

    <p>Thank you for trusting Team Sphere with your information. We are committed to safeguarding your privacy while providing you with the best experience possible!</p>
  </div>
</body>
</html>
        ''',
        ),
      ),
    );
  }
}
