class BABICNonCompostableRequest {
  final title;
  final description;
  bool? isChecked;
  final materialType;

  BABICNonCompostableRequest({
    this.title,
    this.description,
    this.isChecked,
    this.materialType,
  });

  factory BABICNonCompostableRequest.fromMap(Map<String, dynamic> map) =>
      BABICNonCompostableRequest(
        title: map['title'],
        description: map['description'],
        isChecked: map['isChecked'],
        materialType: map['materialType'],
      );
}

class BABICCompostable {
  final title;
  final description;
  bool? isCheck;
  final materialType;

  BABICCompostable({
    this.title,
    this.description,
    this.isCheck,
    this.materialType,
  });

  factory BABICCompostable.fromMap(Map<String, dynamic> map) =>
      BABICCompostable(
        title: map['title'],
        description: map['description'],
        isCheck: map['isCheck'],
        materialType: map['materialType'],
      );
}
