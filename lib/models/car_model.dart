class CarModel {
  final String name;
  final String color;
  final String number;

  CarModel({
    required this.name,
    required this.color,
    required this.number,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color,
        'number': number,
      };

  static CarModel fromJson(Map<String, dynamic> json) => CarModel(
        name: json['name'],
        color: json['color'],
        number: json['number'],
      );
}
