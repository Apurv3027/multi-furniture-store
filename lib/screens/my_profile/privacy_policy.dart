import 'package:flutter/material.dart';
import 'package:Reflex_Furniture/config/colors.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0.0,
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 18,
            color: colorFFFFFF,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/icons/reflex-furniture-rb.png'),
                backgroundColor: color5254A8,
                radius: 50,
              ),
            ).paddingOnly(bottom: 20),
            Text(
              'Effective date: April 27, 2023\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Thank you for using our e-commerce application (“Reflex Furniture”). This Privacy Policy explains how we collect, use, and disclose your personal information when you use our App.\n',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              'We take your privacy seriously and are committed to protecting your personal information. By using our App, you agree to the collection, use, and disclosure of your personal information as described in this Privacy Policy.\n \n',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              '1) Information We Collect',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '=> We may collect personal information from you, such as your name, email address, and shipping address, when you use our App. We may also collect information about your device, such as your IP address and browser type.\n',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              '2) How We Use Your Information',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '=> We may use your personal information to provide you with the services offered by our App, to communicate with you about your orders, and to improve our App. We may also use your information to analyze trends and preferences and to personalize your experience on our App.\n',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              '3) Your Choices',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '=> You can opt out of receiving marketing emails from us by following the unsubscribe link. You can also request that we delete your personal information by contacting us at staticstartupdeveloper@gmail.com.\n',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              '4) Security',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '=> We take reasonable measures to protect your personal information from unauthorized access or disclosure. However, no data transmission over the Internet or storage system can be guaranteed 100% secure.\n',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              '5) Changes to This Privacy Policy',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '=> We may update this Privacy Policy occasionally by posting a new version of our App. We encourage you to review this Privacy Policy periodically to stay informed about our information practices.\n',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              '6) Contact Us',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '=> If you have any questions or concerns about this Privacy Policy, please contact us at staticstartupdeveloper@gmail.com.\n',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ).paddingAll(15),
      ),
    );
  }
}
