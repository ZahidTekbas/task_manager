class Task {
  int id;
  String name;
  String description;
  int date;
  String type;
  bool isChecked;

  Task({this.id ,this.name, this.date, this.type, this.description});

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

  void setDate(int date) {
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
    map['name'] = name;
    if (date != null) {
      map['date'] = date;
    }
    map['description'] = description;
    map['type'] = type;

    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.date = map['date'];
    this.type = map['type'];
    this.description = map['description'];
  }
}
