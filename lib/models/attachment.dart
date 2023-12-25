class Attachment {
  String? id;
  String? fileName;
  int? fileSize;
  String? fileType;
  String? key;
  String? documentType;

  Attachment({
    this.id,
    this.fileName,
    this.fileSize,
    this.fileType,
    this.key,
    this.documentType,
  });

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    fileName = json['FileName'];
    fileSize = json['FileSize'].toInt();
    fileType = json['FileType'];
    key = json['Key'];
    documentType = json['DocumentType'];
  }
}
