import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarsLiist extends StatefulWidget {
  const CarsLiist({super.key});

  @override
  State<CarsLiist> createState() => _CarsLiistState();
}

class _CarsLiistState extends State<CarsLiist> {
  String carNumber = '';

  Widget buildCar(String name, String color, String number, String house) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(number),
      ),
      title: Text('Марка: $name\nЦвет: $color'),
      subtitle: Text('Номер квартиры: $house'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Введите гос номер машины',
              labelText: 'Поиск по гос номеру',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
            onChanged: (value) {
              setState(() {
                carNumber = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('cars').snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          if (carNumber.isEmpty) {
                            return buildCar(data['name'], data['color'], data['number'].toString(), data['house']);
                          }
                          if (data['number'].startsWith(carNumber)) {
                            return buildCar(data['name'], data['color'], data['number'].toString(), data['house']);
                          }
                          return Container(color: Colors.red);
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
