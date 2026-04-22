class EnumValue {
  ///
  dynamic value;

  ///
  String description = '';

  EnumValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    description = json['description'] ?? '';
  }

  Map toJson() {
    return {}
      ..['value'] = value
      ..['description'] = description;
  }
}
