import 'dart:convert';
import 'dart:io';
import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/UI/dashboardscreen.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/Presentation/Profile%20Screen/widgets/profiletextform.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Editprofilescreen extends StatefulWidget {
  final String id;
  const Editprofilescreen({super.key, required this.id});

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

class _EditprofilescreenState extends State<Editprofilescreen> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController mobilenumberrcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = true; // To track if data is being fetched

  /// Function to Pick Image from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  /// Bottom Sheet for Choosing Image Source
  void _showImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Pick from Gallery"),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  }),
              ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a Photo"),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).users[0];
    fullnamecontroller.text = user.fullName;
    mobilenumberrcontroller.text = user.contactNumber;
    emailcontroller.text = user.email;
    datecontroller.text = user.dateOfBirth;
    gendercontroller.text = user.gender;
    citycontroller.text = user.city;
    pincodecontroller.text = user.zipCode;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullnamecontroller.dispose();
    mobilenumberrcontroller.dispose();
    emailcontroller.dispose();
    datecontroller.dispose();
    gendercontroller.dispose();
    citycontroller.dispose();
    pincodecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboardscreen()));
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
        backgroundColor: appColor,
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: displaysize.height * .02,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : NetworkImage(user.users[0].avatar),
                      radius: displaysize.height * .07,
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            _showImagePicker();
                          },
                          child: Container(
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: const EdgeInsets.all(7.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90.0),
                                  color: appColor)),
                        )),
                  ],
                ),
                SizedBox(
                  height: displaysize.height * .02,
                ),
                Profiletextform(
                  hint: 'Edit the Full Name',
                  icon: Icons.person_outline,
                  controller: fullnamecontroller,
                  validator: (value) {
                    if (fullnamecontroller.text.isEmpty) {
                      return 'Edit the name';
                    } else {
                      return null;
                    }
                  },
                ),
                Profiletextform(
                  hint: 'Edit the of Birth',
                  icon: Icons.calendar_today_outlined,
                  controller: datecontroller,
                  validator: (value) {
                    if (datecontroller.text.isEmpty) {
                      return 'Edit the date';
                    } else {
                      return null;
                    }
                  },
                ),
                Profiletextform(
                  hint: 'Edit the Gender',
                  icon: Icons.male_outlined,
                  controller: gendercontroller,
                  validator: (value) {
                    if (gendercontroller.text.isEmpty) {
                      return 'Edit the gender';
                    } else {
                      return null;
                    }
                  },
                ),
                Profiletextform(
                  hint: 'Edit the Mobile Number',
                  icon: Icons.phone_android_outlined,
                  controller: mobilenumberrcontroller,
                  validator: (value) {
                    if (mobilenumberrcontroller.text.isEmpty) {
                      return 'Edit the mobile number';
                    } else {
                      return null;
                    }
                  },
                ),
                Profiletextform(
                  hint: 'Edit the Email',
                  icon: Icons.email_outlined,
                  controller: emailcontroller,
                  validator: (value) {
                    if (emailcontroller.text.isEmpty) {
                      return 'Edit the email';
                    } else {
                      return null;
                    }
                  },
                ),
                Profiletextform(
                  hint: 'Edit the City',
                  icon: Icons.location_city_outlined,
                  controller: citycontroller,
                  validator: (value) {
                    if (citycontroller.text.isEmpty) {
                      return 'Edit the city';
                    } else {
                      return null;
                    }
                  },
                ),
                Profiletextform(
                  hint: 'Edit the Pincode',
                  icon: Icons.location_on_outlined,
                  controller: pincodecontroller,
                  validator: (value) {
                    if (pincodecontroller.text.isEmpty) {
                      return 'Edit the pincode';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: displaysize.height * .02,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    onPressed: () async {
                      if (fullnamecontroller.text != user.users[0].fullName ||
                          datecontroller.text != user.users[0].dateOfBirth ||
                          gendercontroller.text != user.users[0].gender ||
                          mobilenumberrcontroller.text !=
                              user.users[0].contactNumber ||
                          emailcontroller.text != user.users[0].email ||
                          citycontroller.text != user.users[0].city ||
                          pincodecontroller.text != user.users[0].zipCode ||
                          _image != null) {
                        if (_formKey.currentState!.validate()) {
                          updateProfileApi(context);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar('User data not changed!'));
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: displaysize.height * .1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> updateProfileApi(BuildContext context) async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://srishticampus.tech/bloodconnect/phpfiles/api/edit_profile.php'),
      );

      request.fields.addAll({
        'user_id': '${user.users[0].id}',
        'name': fullnamecontroller.text.trim(),
        'dob': datecontroller.text,
        'gender': gendercontroller.text.trim(),
        'blood_group': '${user.users[0].bloodGroup}',
        'weight': '${user.users[0].weight}',
        'contact_no': mobilenumberrcontroller.text.trim(),
        'email': emailcontroller.text.trim(),
        'city': citycontroller.text.trim(),
        'zip_code': pincodecontroller.text.trim(),
        'health_status': '${user.users[0].healthStatus}',
        'avatar': '${user.users[0].avatar}'
      });

      if (_image != null && _image!.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('avatar', _image!.path));
      }

      var response = await request.send().timeout(Duration(seconds: 10));
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      print(jsonResponse);

      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Dashboardscreen()),
            (Route<dynamic> route) => false);
        GlobalAlertDialog.show(context,
            value: 1, msg: 'Successfully updated profile');
      }
    } catch (e) {}
  }
}
