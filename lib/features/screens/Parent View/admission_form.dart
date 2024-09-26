import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../personalization/user_panel/controller/userattendance_controller.dart';
import '../../../personalization/user_panel/controller/userdetails_controller.dart';

class AdmissionForm extends StatefulWidget {
  @override
  _AdmissionFormState createState() => _AdmissionFormState();
}

class _AdmissionFormState extends State<AdmissionForm> {
  final UserDetailsController _controller = Get.put(UserDetailsController());

  @override
  void initState() {
    super.initState();
    _controller.fetchUserProfile(); // Fetch user profile data on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Record', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (_controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text('Error: ${_controller.errorMessage.value}'),
          );
        } else if (_controller.userDetails.value == null) {
          return Center(
            child: Text('No data available'),
          );
        } else {
          final userData = _controller.userDetails.value!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Player’s name:'),
                      subtitle: Text(
                        userData.name != null
                            ? '${_capitalize(userData.name)} ${_capitalize(userData.lastname)}'
                            : 'N/A',
                      ),
                    ),
                    ListTile(
                      title: Text('Address:'),
                      subtitle: Text(userData.address ?? 'N/A'),
                    ),
                    ListTile(
                      title: Text('Date of Birth:'),
                      subtitle: Text(userData.dob ?? 'N/A'),
                    ),
                    ListTile(
                      title: Text('Email:'),
                      subtitle: Text(userData.email ?? 'N/A'),
                    ),
                    ListTile(
                      title: Text('Gender:'),
                      subtitle: Text(userData.gender == 'male' ? 'male' : 'female'),
                    ),
                    ListTile(
                      title: Text('Status:'),
                      subtitle: Text(
                        userData.status == 'active' ? 'active' : 'inactive',
                        style: TextStyle(
                          color: userData.status == 'active' ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Are You A Club Member'),
                      subtitle: Text(userData.clubmembership ?? 'N/A'),
                    ),
                    ListTile(
                      title: Text('Creek Club Card Copy:'),
                      subtitle: Text(userData.clubcardcopy == 'Yes' ? 'Yes' : 'No'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  String _capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
