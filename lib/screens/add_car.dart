import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opera_parking/constants/text_field.dart';
import 'package:opera_parking/models/car_model.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController houseController = TextEditingController();

  bool isCarNumberEmpty = false;

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
                    'Машина успешно\nдобавлена!',
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          defTextField(nameController, 'Марка Машины', false),
          const SizedBox(height: 20),
          defTextField(colorController, 'Цвет Машины', false),
          const SizedBox(height: 20),
          TextField(
            controller: numberController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                value = numberController.text;
                if (value.isNotEmpty) {
                  isCarNumberEmpty = true;
                } else {
                  isCarNumberEmpty = false;
                }
              });
            },
            decoration: InputDecoration(
              labelText: 'Гос номер машины*',
              hintText: 'Обязаельное поле*',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 20),
          defTextField(houseController, 'Номер квартиры', true),
          const Spacer(),
          SizedBox(
            width: 300,
            height: 80,
            child: ElevatedButton(
              onPressed: !isCarNumberEmpty
                  ? null
                  : () {
                      final json = CarModel(
                        name: nameController.text,
                        color: colorController.text,
                        number: numberController.text,
                        house: houseController.text,
                      );
                      createCar(json).then((_) {
                        infoDialog();
                        nameController.clear();
                        colorController.clear();
                        numberController.clear();
                        houseController.clear();
                      });
                    },
              child: const Text(
                'Добавить машину',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
