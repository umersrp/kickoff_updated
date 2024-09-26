import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../personalization/admin_panel/controllers/playerRecords_controller.dart';
import '../../../personalization/admin_panel/models/playerrecords_model.dart';


class Reg_list extends StatefulWidget {
  @override
  _Reg_listState createState() => _Reg_listState();
}

class _Reg_listState extends State<Reg_list> {
  final PlayerrecordsController controller = Get.put(PlayerrecordsController());
  final TextEditingController _searchController = TextEditingController();
  List<User> filteredList = [];

  @override
  void initState() {
    super.initState();
    controller.fetchUsers();
  }

  void _showExtraInfoDialog(BuildContext context, String childName, String address, String dateOfBirth, String phoneNumber, bool isMale, bool isClubMember) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Extra Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Child Name: $childName'),
              Text('Address: $address'),
              Text('Date Of Birth: $dateOfBirth'),
              Text('Phone Number: $phoneNumber'),
              Text('Gender: ${isMale ? 'Male' : 'Female'}'),
              Text('Club Member: ${isClubMember ? 'Yes' : 'No'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        title: Text('Players Records', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xff2e2d77)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }

                if (controller.users.value.isEmpty) {
                  return Center(child: Text('No data available.'));
                }

                final users = _searchController.text.isEmpty
                    ? controller.users.value
                    : filteredList;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            _showExtraInfoDialog(
                              context,
                              user.name, // Assuming this is the child's name
                              user.address,
                              user.dob,
                              user.phone,
                              user.gender == 'male', // Assuming gender is a string
                              user.clubmembership == 'true' || user.clubmembership == true, // Check and convert to bool
                            );
                          },


                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          title: Text(
                            'Parent Name: ${user.parentname}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.0),
                              Text(
                                'Email: ${user.email}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'First Name: ${user.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Last Name: ${user.lastname}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Groups: ${user.schedules.isEmpty ? 'No groups' : user.schedules.join(', ')}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'DACC Membership No: ${user.dacc ?? ''}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Status: ${user.status}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Creation Date: ${user.date.toLocal()}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Text(
                                    'Fees Status: ${user.feestatus}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Switch(
                            value: user.status == 'active',
                            onChanged: (val) async {
                              await controller.updateUserStatus(user.id, val);
                              setState(() {
                                user.status = val ? 'active' : 'inactive';
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
