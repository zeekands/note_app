class NotesModel {
  int? id;
  String? title;
  String? description;
  String? time;
  String? file;
  String? interval;
  String? isReminder;

  NotesModel({
    this.id,
    this.title,
    this.description,
    this.time,
    this.file,
    this.interval,
    this.isReminder,
  });

  NotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    time = json['time'];
    file = json['file'];
    interval = json['interval'];
    isReminder = json['isReminder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['time'] = this.time;
    data['file'] = this.file;
    data['interval'] = this.interval;
    data['isReminder'] = this.isReminder;
    return data;
  }
}
