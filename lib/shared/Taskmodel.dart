class Taskmodel {
  String Title;
  String Description;
  String Id = '';
  bool? Isdone = false;
  int Date;

  Taskmodel({
    required this.Title,
    required this.Description,
    required this.Id,
    this.Isdone,
    required this.Date,
  });

  factory Taskmodel.fromJson(Map<String, dynamic> data) {
    return Taskmodel(
      Title: data['Title'],
      Description: data['Description'],
      Id: data['Id'],
      Isdone: data['Isdone'],
      Date: data['Date'],
    );
  }

  Map<String, dynamic> tojhson() {
    return {
      'Title': Title,
      'Description': Description,
      'Id': Id,
      'Isdone': Isdone,
      'Date': Date,
    };
  }
}
