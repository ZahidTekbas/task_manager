class Task {
  int id;
  String name;
  String description;
  String date;
  bool isChecked;

  Task({this.name, this.isChecked = false, this.date, this.description});
  Task.withId(
      {this.id, this.description, this.name, this.isChecked, this.date});
  Task.withoutDate(
      {this.id, this.name, this.isChecked = false, this.description});

  void toggleDone() {
    isChecked = !isChecked;
  }

  void setId(int id) {
    this.id = id;
  }

  void setName(String value) {
    this.name = value;
  }

  void setIsChecked(bool value) {
    this.isChecked = value;
  }

  void setDate(String date) {
    this.date = date;
  }

  void setDescription(String description) {
    this.description = description;
  }

  getId() {
    return this.id;
  }

  getName() {
    return this.name;
  }

  getIsChecked() {
    return this.isChecked;
  }

  getDate() {
    return this.date;
  }

  getDescription() {
    return this.description;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['isChecked'] = 'false';
    map['name'] = name;
    if (date != null) {
      map['date'] = date;
    }

    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.isChecked = false;
    this.date = map['date'];
  }
}
