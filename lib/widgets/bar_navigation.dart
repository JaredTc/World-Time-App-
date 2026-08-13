import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:world_time_app/providers/time_provider.dart';

// ignore: must_be_immutable
class BarNavigateWidget extends StatelessWidget {
  bool reload = false;
  bool isPressed = true; // Variable para controlar el estado del botón

  BarNavigateWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  this.isPressed = false; // Cambia el estado del botón
                  reload = true;
                  Provider.of<TimeProvider>(
                    context,
                    listen: false,
                  ).updateAllTimes();
                  // print('Reload: $reload');

                  // Acción al presionar el botón de retroceso
                },
              ),
            ),
            SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                color: isPressed ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: const Icon(Icons.language, color: Colors.white),
                onPressed: () {
                  // Acción al presionar el botón de retroceso
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
