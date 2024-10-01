import 'package:appkickoff/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../personalization/controllers/create_user_controller.dart';
import '../../../../personalization/controllers/schedule_controller.dart';
import '../../../../personalization/models/schedule_model.dart';
import '../../../../personalization/models/user_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final SignupController signupController = Get.put(SignupController());
  final ScheduleController scheduleController = Get.put(ScheduleController());
  String selectedLocation = 'DA CREEK CLUB, KARACHI';
  String? selectedSchedule;
  ScheduleModel? selectedScheduleItem;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController parentnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController scheduleIdsController = TextEditingController();
  final TextEditingController daccController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController clubmembershipController = TextEditingController();
  final TextEditingController clubcardcopyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }


  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('firstName') ?? '';
      lastnameController.text = prefs.getString('lastName') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Email label and input field.
            SizedBox(height: 25,),
          TextFormField(
            controller: nameController,
            readOnly: true,
            decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.signature,color: MyColors.primary,),
            hintText: 'First Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
            ),
          ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),

          SizedBox(height: 10,),

          TextFormField(
            controller: lastnameController,
            readOnly: true, // Make it read-only
            decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.person,color: MyColors.primary,),
            hintText: 'Last Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
            ),
          ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Last name';
              }
              return null;
            },
          ),

            SizedBox(height: 10,),

            TextFormField(controller: parentnameController, decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.handsHoldingChild,color: MyColors.primary,),
            hintText: 'Parent Name',

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
            ),
          ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Parent name';
                }
                return null;
              },
            ),

            SizedBox(height: 10,),

            TextFormField(
              controller: emailController,
              readOnly: true, // Make it read-only

              decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email,color: MyColors.primary,),
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
            ),
          ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),

            TextFormField(
              controller: phoneController,
              readOnly: true, // Make it read-only
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  FontAwesomeIcons.phone,
                  color: MyColors.primary,
                ),
                hintText: 'Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number, // To show numeric keyboard
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
                LengthLimitingTextInputFormatter(11), // Limit input to 11 digits
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                } else if (value.length != 11) {
                  return 'Phone number must be 11 digits';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),

            TextFormField(controller: addressController, decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.house,color: MyColors.primary,),
            hintText: 'Address',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
            ),
          ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Address';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.calendar, color: MyColors.primary),
                hintText: 'Select a schedule',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
              ),
              isExpanded: true,
              value: selectedSchedule,
              items: scheduleController.scheduleData.map((schedule) {
                return DropdownMenuItem<String>(
                  value: schedule.group,
                  child: Text(schedule.group),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSchedule = value;
                });

                // Find the selected schedule and print its ID
                final selectedScheduleItem = scheduleController.scheduleData.firstWhere(
                      (schedule) => schedule.group == value,
                  orElse: () => ScheduleModel(
                    id: '',
                    group: '',
                    days: [],
                    startTime: '',
                    endTime: '',
                    ages: '',
                    location: '',
                    v: 0,
                    date: DateTime.now(),
                  ),
                );

                print('Selected Schedule ID: ${selectedScheduleItem.id}');
              },
            ),
            Divider(height: 10, endIndent: 5, indent: 5, thickness: 1, color: Colors.grey),
          ],
        ),
            SizedBox(height: 10,),

            TextFormField(
              controller: dobController,
              readOnly: true, // Make the TextField read-only so the user can't manually input the date
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(FontAwesomeIcons.calendarPlus, color: MyColors.primary),
                  onPressed: () async {
                    // Show the date picker and wait for the user to select a date
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), // Set the initial date to the current date
                      firstDate: DateTime(1900), // Set the earliest date
                      lastDate: DateTime.now(), // Set the latest date
                    );

                    if (pickedDate != null) {
                      // Format the date and display it in the TextField
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      dobController.text = formattedDate;
                    }
                  },
                ),
                hintText: 'Date Of Birth',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Date Of Birth';
                }
                return null;
              },
              onTap: () async {
                // Open the date picker when the TextField is tapped
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  // Format the selected date and display it in the TextField
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  dobController.text = formattedDate;
                }
              },
            ),


            SizedBox(height: 10,),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Gender:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16.0), // Space between the heading and checkboxes
            Obx(() => Row(
              children: <Widget>[
                Checkbox(
                  value: signupController.selectedGender.value == 'Male',
                  onChanged: (bool? value) {
                    signupController.selectedGender.value = value == true ? 'Male' : 'N/A';
                  },
                ),
                const Text('Male'),
              ],
            )),
            SizedBox(width: 16.0), // Space between Male and Female checkboxes
            Obx(() => Row(
              children: <Widget>[
                Checkbox(
                  value: signupController.selectedGender.value == 'Female',
                  onChanged: (bool? value) {
                    signupController.selectedGender.value = value == true ? 'Female' : 'N/A';
                  },
                ),
                const Text('Female'),
              ],
            )),
          ],
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Are You DACC Member',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16.0), // Space between the heading and checkboxes
                Obx(() => Row(
                  children: <Widget>[
                    Checkbox(
                      value: signupController.DACCMembership.value == 'Yes',
                      onChanged: (bool? value) {
                        signupController.DACCMembership.value = value == true ? 'Yes' : 'N/A';
                      },
                    ),
                    const Text('Yes'),
                  ],
                )),
                SizedBox(width: 16.0), // Space between Male and Female checkboxes
                Obx(() => Row(
                  children: <Widget>[
                    Checkbox(
                      value: signupController.DACCMembership.value == 'No',
                      onChanged: (bool? value) {
                        signupController.DACCMembership.value = value == true ? 'No' : 'N/A';
                      },
                    ),
                    const Text('No'),
                  ],
                )),
              ],
            ),

            SizedBox(height: 10,),

            TextFormField(controller: clubmembershipController, decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.memory,color: MyColors.primary,),
            hintText: 'DACC Membership Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
            ),
          ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Date Of Birth';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Creek Club Card Copy',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16.0), // Space between the heading and checkboxes
                Obx(() => Row(
                  children: <Widget>[
                    Checkbox(
                      value: signupController.selectedClubCard.value == 'Yes',
                      onChanged: (bool? value) {
                        signupController.selectedClubCard.value = value == true ? 'Yes' : 'N/A';
                      },
                    ),
                    const Text('Yes'),
                  ],
                )),
                SizedBox(width: 16.0), // Space between Male and Female checkboxes
                Obx(() => Row(
                  children: <Widget>[
                    Checkbox(
                      value: signupController.selectedClubCard.value == 'No',
                      onChanged: (bool? value) {
                        signupController.selectedClubCard.value = value == true ? 'No' : 'N/A';
                      },
                    ),
                    const Text('No'),
                  ],
                )),
              ],
            ),


            SizedBox(height: 10,),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock,color: MyColors.primary,),
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Date Of Birth';
                }
                return null;
              },
              obscureText: _obscurePassword,
            ),



            const SizedBox(height: 16.0),

            /// Sign In button.
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                return signupController.isLoading.value
                    ? Center(
                  child: Container(
                    width: 24.0,  // Adjust width as needed
                    height: 24.0, // Adjust height as needed
                    child: CircularProgressIndicator(),
                  ),
                )
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: MyColors.primary,
                  ),
                  onPressed: () {
                    // Validation function
                    void showValidationDialog(String title, String content) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(title),
                            content: Text(content),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    // Validate first name
                    if (nameController == null || nameController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your First Name');
                      return;
                    }

                    // Validate last name
                    if (lastnameController == null || lastnameController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Last Name');
                      return;
                    }

                    // Validate email
                    if (emailController == null || emailController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your email address');
                      return;
                    } else if (emailController.text.trim().contains(RegExp(r'[A-Z]'))) {
                      showValidationDialog('Invalid Input', 'Email should not contain uppercase letters');
                      return;
                    } else if (!emailController.text.trim().contains('@') || !emailController.text.trim().contains('.')) {
                      showValidationDialog('Invalid Format', 'Email format is invalid');
                      return;
                    }

                    // Validate parent name
                    if (parentnameController == null || parentnameController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Parent Name');
                      return;
                    }

                    // Validate selected shift
                    if (phoneController == null || phoneController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Phone Number');
                      return;
                    }

                    // Validate address
                    if (addressController == null || addressController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Address');
                      return;
                    }

                    if (dobController == null || dobController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Date Of Birth');
                      return;
                    }

                    if ( clubmembershipController == null || clubmembershipController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your MememberShip Number');
                      return;
                    }

                    if ( passwordController == null || passwordController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Password');
                      return;
                    }


                    // Fetch selected schedule from scheduleController
                    final selectedScheduleItem = scheduleController.scheduleData.firstWhere(
                          (schedule) => schedule.group == selectedSchedule,
                      orElse: () => ScheduleModel(
                        id: '',
                        group: '',
                        days: [],
                        startTime: '',
                        endTime: '',
                        ages: '',
                        location: '',
                        v: 0,
                        date: DateTime.now(),
                      ),
                    );

                    // Create a UserModel with filled data
                    final userModel = UserModel(
                      name: nameController.text,
                      lastname: lastnameController.text.isEmpty ? 'N/A' : lastnameController.text,
                      parentname: parentnameController.text.isEmpty ? 'N/A' : parentnameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text.isEmpty ? 'N/A' : phoneController.text,
                      address: addressController.text.isEmpty ? 'N/A' : addressController.text,
                      dacc: signupController.DACCMembership.value,
                      dob: dobController.text, // Selected Date of Birth
                      gender: signupController.selectedGender.value,
                      clubmembership: clubmembershipController.text.isEmpty ? 'N/A' : clubmembershipController.text,
                      clubcardcopy: signupController.selectedClubCard.value,
                      scheduleIds: selectedScheduleItem.id,
                      regestrationtype: 'academy',
                    );

                    // Call the signup method with the user model
                    signupController.signupUser(userModel, context);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),




          ],
        ),
      ),
    );
  }
}
