class CarModel {
  final String name;
  final String color;
  final String number;
  final String house;

  CarModel({
    required this.name,
    required this.color,
    required this.number,
    required this.house,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color,
        'number': number,
        'house': house,
      };

  static CarModel fromJson(Map<String, dynamic> json) => CarModel(
        name: json['name'],
        color: json['color'],
        number: json['number'],
        house: json['house'],
      );
}
