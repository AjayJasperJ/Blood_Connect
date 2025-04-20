class OrganizationModel {
 final String  organizationId;
 final String  name;
 final String  regNo;
 final String  contactNo;
 final String  email;
 final String  city;

  OrganizationModel(
      {required this.organizationId,
      required this.name,
      required this.regNo,
      required this.contactNo,
      required this.email,
      required this.city});

factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
    organizationId: json['organization_id'],
    name: json['name'],
    regNo: json['reg_no'],
    contactNo: json['contact_no'],
    email: json['email'],
    city: json['city'],
    );
   
  }
}