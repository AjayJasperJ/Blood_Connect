import 'dart:convert';
import 'dart:io';

import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/widgets/dialogie.dart';
import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/UI/loginscreen.dart';
import 'package:blood_bank_application/Registeration%20Screens/RegisterScreen/widgets/listdats.dart';
import 'package:blood_bank_application/Registeration%20Screens/RegisterScreen/widgets/registerfarm.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;

import 'package:blood_bank_application/Global/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  TextEditingController fullNamecontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();

  var selectedGender = '';
  var selectedBloodGroup = '';
  var selecthealth = '';
  final _formKey = GlobalKey<FormState>();
  void showToast(BuildContext context, String title, String description,
      ToastificationType type) {
    toastification.show(
      context: context,
      type: type,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(description),
      primaryColor: Colors.white,
      autoCloseDuration: const Duration(seconds: 3),
      progressBarTheme: ProgressIndicatorThemeData(
        color: type == ToastificationType.success
            ? appColor
            : type == ToastificationType.info
                ? Colors.blue
                : type == ToastificationType.warning
                    ? Colors.orange
                    : Colors.grey,
      ),
      showProgressBar: true,
      backgroundColor: type == ToastificationType.success
          ? appColor
          : type == ToastificationType.info
              ? Colors.blue
              : type == ToastificationType.warning
                  ? Colors.orange
                  : Colors.grey,
      foregroundColor: Colors.white,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime minDate =
        DateTime(now.year - 60, now.month, now.day + 1); // 60 years ago
    final DateTime maxDate = DateTime(now.year - 18, now.month,
        now.day - 1); // 18 years ago (excluding today)

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxDate, // Default to 18 years ago
      firstDate: minDate, // Minimum age: 60 years old
      lastDate: maxDate, // Maximum age: 18 years old (yesterday)
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.white,
              onPrimary: appColor,
              surface: appColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      int age = now.year - picked.year;

      // Adjust age calculation if birthday hasn't occurred yet this year
      if (picked.month > now.month ||
          (picked.month == now.month && picked.day > now.day)) {
        age--;
      }

      if (age < 18 || age > 60) {
        // Show error if the selected age is outside the range
        MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Age must be between 18 and 60 years.",
          onTapOkButt: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        // Format and set the valid date
        String formattedDate = "${picked.day}-${picked.month}-${picked.year}";
        dateController.text = formattedDate;
      }
    }
  }

  XFile? file;
  String? base64Image;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      Navigator.pop(context);
      setState(() {
        file = pickedFile;
      });

      // Convert image to base64
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }
  }

  Future<void> registerBloodbank(
      File? imageFile,
      String name,
      String dob,
      String gender,
      String bloodgroup,
      String phone,
      String email,
      String city,
      String pincode,
      String password,
      String health,
      String weight) async {
    print('Register API running');
    const url =
        'https://srishticampus.tech/bloodconnect/phpfiles/api/donor_reg.php';

    try {
      var request = https.MultipartRequest('POST', Uri.parse(url));

      // Attach the image file if selected
      if (imageFile != null) {
        request.files
            .add(await https.MultipartFile.fromPath('avatar', imageFile.path));
      }

      // Add other form fields
      request.fields.addAll({
        'name': name,
        'dob': dob,
        'gender': gender,
        'blood_group': bloodgroup,
        'contact_no': phone,
        'email': email,
        'city': city,
        'zip_code': pincode,
        'password': password,
        'health_status': health,
        'weight': weight,
      });

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var jsonData = json.decode(responseBody);

      if (response.statusCode == 200 && jsonData['status'] == true) {
        if (jsonData['status'] == true) {
          showToast(context, 'Register', 'Registration Successful',
              ToastificationType.success);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      }
    } catch (error) {}
  }

  void registerButton() {
    if (file == null) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please select an image",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (fullNamecontroller.text.trim().isEmpty ||
        !RegExp(r'^[a-zA-Z\s]+$').hasMatch(fullNamecontroller.text.trim())) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter a valid Full Name (only letters allowed)",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (dateController.text.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Date of Birth",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (selectedGender.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Gender",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (selectedBloodGroup.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Blood Group",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (phoneController.text.trim().isEmpty ||
        !RegExp(r'^[1-9][0-9]{9}$').hasMatch(phoneController.text.trim())) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle:
              "Invalid phone number! Please enter a valid 10-digit number that does not start with 0.",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
      return;
    } else if (emailController.text.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Email",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (cityController.text.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter City",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (pincodeController.text.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Pincode",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (passwordcontroller.text.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Password",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (selecthealth.trim().isEmpty || selecthealth != "None") {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle:
              "Donor with diseases are not allowed to register for donation",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (weightcontroller.text.trim().isEmpty ||
        double.tryParse(weightcontroller.text.trim()) == null ||
        double.parse(weightcontroller.text.trim()) < 50 ||
        double.parse(weightcontroller.text.trim()) > 100) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Weight must be a number between 50 and 100",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else {
      registerBloodbank(
          File(file!.path),
          fullNamecontroller.text,
          dateController.text,
          selectedGender.toString(),
          selectedBloodGroup.toString(),
          phoneController.text,
          emailController.text,
          cityController.text,
          pincodeController.text,
          passwordcontroller.text,
          selecthealth.toString(),
          weightcontroller.text);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNamecontroller.dispose();
    dateController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    passwordcontroller.dispose();
    weightcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Center(
                        child: Stack(children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: purewhite,
                            backgroundImage: file != null
                                ? FileImage(File(file!.path))
                                : null,
                            child: file == null
                                ? const Icon(Icons.camera_alt,
                                    size: 50, color: Colors.black)
                                : null,
                          ),
                          Positioned(
                              right: 5,
                              bottom: 0,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (builder) => bottomSheet());
                                },
                                child: Container(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: purewhite,
                                      size: 20,
                                    ),
                                    padding: const EdgeInsets.all(7.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: appColor),
                                        borderRadius:
                                            BorderRadius.circular(90.0),
                                        color: appColor)),
                              ))
                        ]),
                      ),
                      registerFieldName(title: 'Full Name'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'Full Name',
                        icon: Icons.person_outline,
                        controller: fullNamecontroller,
                        onTap: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Date of Birth'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'Date of Birth (Age 18 to 65 )',
                        icon: Icons.calendar_month_outlined,
                        controller: dateController,
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Gender'),
                      SizedBox(height: size.height * 0.01),
                      DropdownButtonFormField<String>(
                        focusColor: purewhite,
                        dropdownColor: purewhite,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select your gender';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          prefixIcon:
                              Icon(Icons.male_outlined, color: appColor),
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        value: selectedGender,
                        items: genderOptions
                            .map((gender) => DropdownMenuItem<String>(
                                  value: gender,
                                  child: Row(
                                    children: [
                                      SizedBox(width: displaysize.width * .03),
                                      Text(
                                        gender.isEmpty ? 'Select' : gender,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Blood Group'),
                      SizedBox(height: size.height * 0.01),
                      DropdownButtonFormField<String>(
                        dropdownColor: purewhite,
                        focusColor: purewhite,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select your blood group';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          prefixIcon:
                              Icon(Icons.bloodtype_outlined, color: appColor),
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        value: selectedBloodGroup,
                        items: bloodGroups
                            .map((group) => DropdownMenuItem<String>(
                                  value: group,
                                  child: Row(
                                    children: [
                                      SizedBox(width: displaysize.width * .03),
                                      Text(
                                        group.isEmpty ? 'Select' : group,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedBloodGroup = value!;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Mobile Number'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'Mobile Number',
                        icon: Icons.phone_android_outlined,
                        controller: phoneController,
                        onTap: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Email'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        controller: emailController,
                        onTap: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'City'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'City',
                        icon: Icons.location_on_outlined,
                        controller: cityController,
                        onTap: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Pincode'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'Pincode',
                        icon: Icons.location_on_outlined,
                        controller: pincodeController,
                        onTap: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Password'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'Password',
                        icon: Icons.lock_outlined,
                        controller: passwordcontroller,
                        onTap: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Health'),
                      SizedBox(height: size.height * 0.01),
                      DropdownButtonFormField<String>(
                        dropdownColor: purewhite,
                        focusColor: purewhite,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select your health';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.health_and_safety_outlined,
                              color: appColor),
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        value: selecthealth,
                        items: healthConditions
                            .map((condition) => DropdownMenuItem<String>(
                                  value: condition,
                                  child: Row(
                                    children: [
                                      SizedBox(width: displaysize.width * .03),
                                      Text(
                                        condition.isEmpty
                                            ? 'Select'
                                            : condition,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selecthealth = value!;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      registerFieldName(title: 'Weight'),
                      SizedBox(height: size.height * 0.01),
                      registerTextField(
                        hintText: 'Weight',
                        icon: Icons.line_weight_outlined,
                        controller: weightcontroller,
                        onTap: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: appColor),
                              onPressed: () {
                                registerButton();
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              "Choose Profile photo",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: appColor),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: appColor),
                ),
              ],
            )
          ],
        ));
  }
}
