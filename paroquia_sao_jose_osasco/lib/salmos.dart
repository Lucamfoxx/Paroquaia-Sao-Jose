import 'package:flutter/material.dart';

class SalmosPage extends StatelessWidget {
  const SalmosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salmos'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: 150,
        itemBuilder: (BuildContext context, int index) {
          final salmoNumber = index + 1;
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/salmo_$salmoNumber',
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 148, 203, 252)
,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '$salmoNumber',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
