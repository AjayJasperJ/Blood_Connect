class UserModel {
  final String id;
  final String email;
  final String role;
  final String fullName;
  final String dateOfBirth;
  final String gender;
  final String bloodGroup;
  final String weight;
  final String contactNumber;
  final String city;
  final String zipCode;
  final String healthStatus;
  final String avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.role,
      required this.fullName,
      required this.dateOfBirth,
      required this.gender,
      required this.bloodGroup,
      required this.weight,
      required this.contactNumber,
      required this.city,
      required this.zipCode,
      required this.healthStatus,
      required this.avatar});

 factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
   id :json['id'],
    email :json['email'],
    role :json['role'],
    fullName :json['full_name'],
    dateOfBirth :json['date_of_birth'],
    gender :json['gender'],
    bloodGroup :json['blood_group'],
    weight :json['weight'],
    contactNumber :json['contact_number'],
    city :json['city'],
    zipCode :json['zip_code'],
    healthStatus :json['health_status'],
    avatar :json['avatar'],
  );
 
  }
}