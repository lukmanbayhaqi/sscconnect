class AppUser {
  int? id;
  int? idpId;
  int? roleId;
  String? formattedId;
  String? inputSource;
  String? name;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? phoneNumber;
  int? superiorId;
  int? defaultCostCenter;
  bool? isActive;
  String? status;
  int? workLocationId;
  int? genderId;
  String? gender;
  String? employmentStatus;
  String? createAt;
  int? createBy;
  dynamic organizations;

  AppUser({
    this.id,
    this.idpId,
    this.roleId,
    this.formattedId,
    this.inputSource,
    this.name,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.superiorId,
    this.defaultCostCenter,
    this.isActive,
    this.status,
    this.workLocationId,
    this.genderId,
    this.gender,
    this.employmentStatus,
    this.createAt,
    this.createBy,
    this.organizations,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    idpId = json['IdpId'];
    roleId = json['RoleId'];
    formattedId = json['FormattedId'];
    inputSource = json['InputSource'];
    name = json['Name'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    superiorId = json['SuperiorId'];
    defaultCostCenter = json['DefaultCostCenter'];
    isActive = json['IsActive'];
    status = json['Status'];
    workLocationId = json['WorkLocationId'];
    genderId = json['GenderId'];
    gender = json['Gender'];
    employmentStatus = json['EmploymentStatus'];
    createAt = json['CreateAt'];
    createBy = json['CreateBy'];
    organizations = json['Organizations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['IdpId'] = idpId;
    data['RoleId'] = roleId;
    data['FormattedId'] = formattedId;
    data['InputSource'] = inputSource;
    data['Name'] = name;
    data['FirstName'] = firstName;
    data['MiddleName'] = middleName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['PhoneNumber'] = phoneNumber;
    data['SuperiorId'] = superiorId;
    data['DefaultCostCenter'] = defaultCostCenter;
    data['IsActive'] = isActive;
    data['Status'] = status;
    data['WorkLocationId'] = workLocationId;
    data['GenderId'] = genderId;
    data['Gender'] = gender;
    data['EmploymentStatus'] = employmentStatus;
    data['CreateAt'] = createAt;
    data['CreateBy'] = createBy;
    data['Organizations'] = organizations;
    return data;
  }
}
