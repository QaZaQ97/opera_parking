import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opera_parking/constants/text_field.dart';
import 'package:opera_parking/models/car_model.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    
    Future createCar(CarModel carModel) async {
      final carData = FirebaseFirestore.instance.collection('cars').doc(numberController.text);
      final user = carModel.toJson();
      await carData.set(user);
    }

    void infoDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return const Dialog(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Машина успешно\nдобавлено!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          defTextField(nameController, 'Марка Машины', false),
          const SizedBox(height: 20),
          defTextField(colorController, 'Цвет Машины', false),
          const SizedBox(height: 20),
          defTextField(numberController, 'Гос номер Машины', true),
          const Spacer(),
          SizedBox(
            width: 300,
            height: 80,
            child: Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final json = CarModel(
                    name: nameController.text,
                    color: colorController.text,
                    number: numberController.text,
                  );
                  createCar(json).then((_) => infoDialog());
                },
                child: const Text('Добавить машину'),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
