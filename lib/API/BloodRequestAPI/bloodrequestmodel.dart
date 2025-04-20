class BloodrequestModel {
  final String id;
  final String patientName;
  final String mrNo;
  final String bystanderName;
  final String bystanderContactNo;
  final String diagnosis;
  final String doctorAssigned;
  final String bloodType;
  final String bloodUnitsRequired;
  final String priority;
  final String requestedDate;

  BloodrequestModel(
      {required this.id,
      required this.patientName,
      required this.mrNo,
      required this.bystanderName,
      required this.bystanderContactNo,
      required this.diagnosis,
      required this.doctorAssigned,
      required this.bloodType,
      required this.bloodUnitsRequired,
      required this.priority,
      required this.requestedDate});

 factory BloodrequestModel.fromJson(Map<String, dynamic> json) {
  return BloodrequestModel(
     id : json['id'],
    patientName : json['patient_name'],
    mrNo : json['mr_no'],
    bystanderName : json['bystander_name'],
    bystanderContactNo : json['bystander_contact_no'],
    diagnosis : json['diagnosis'],
    doctorAssigned : json['doctor_assigned'],
    bloodType : json['blood_type'],
    bloodUnitsRequired : json['blood_units_required'],
    priority : json['priority'],
    requestedDate : json['requested_date'],
  );
   
  }
}