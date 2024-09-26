import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: PrivacyPolicy(),
  ));
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8e8e8),
      appBar: AppBar(
        backgroundColor: Color(0xff2e2d77),
        elevation: 2,
        title: Row(
          children: [
            SizedBox(width: 8),
            Text('Privacy & Policy', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Privacy Policy',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xff2e2d77)),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to our app. Your privacy is important to us.',
                style: TextStyle(fontSize: 18, color: Color(0xff2e2d77)),
              ),
              SizedBox(height: 10),
              SectionHeader(title: '1. Information We Collect'),
              SectionContent(
                content:
                'At Kick Off Academy, we collect and process various types of information, including personal data, to provide and improve our services. The types of information we collect may include but are not limited to:',
              ),
              SectionContent(
                content: '- Personal Information: Contact Information, Date of Birth, Player Information',
              ),
              SectionContent(
                content: '- Usage Data: Website Interaction, Device and Usage Information',
              ),
              // SectionContent(
              //   content: '- Payment Information ',
              // ),
              SectionContent(
                content: '- Communications: Records of correspondence',
              ),
              SectionContent(
                content: '- Information from Third Parties',
              ),
              SectionContent(
                content: '- Cookies and Tracking Technologies',
              ),
              SizedBox(height: 10),
              SectionHeader(title: '2. How We Use Your Information'),
              SectionContent(
                content: 'Kick Off Academy uses the information collected from users for various purposes, including but not limited to:',
              ),
              SectionContent(
                content: '- Providing and Personalizing Services',
              ),
              SectionContent(
                content: '- Communication and Customer Support',
              ),
              SectionContent(
                content: '- Improving Services',
              ),
              SectionContent(
                content: '- Marketing and Promotional Communications',
              ),
              // SectionContent(
              //   content: '- Payment Processing',
              // ),
              SectionContent(
                content: '- Legal Compliance',
              ),
              SectionContent(
                content: '- Research and Analytics',
              ),
              SectionContent(
                content: '- Cookies and Tracking Information',
              ),
              SizedBox(height: 10),
              SectionHeader2(title: '3.Terms And Conditions For Kick Off Academy'),
              SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    launch('https://timetokickoff.com/terms-and-conditions-for-kick-off-academy/');
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xff2e2d77),
                    backgroundImage: AssetImage('assets/kickofflogo.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff2e2d77)),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}

class SectionHeader2 extends StatelessWidget {
  final String title;

  const SectionHeader2({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff2e2d77)),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        content,
        style: TextStyle(fontSize: 16, color: Color(0xff2e2d77)),
      ),
    );
  }
}
