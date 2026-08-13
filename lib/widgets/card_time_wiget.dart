import 'package:flutter/material.dart';

class CardTimeWidget extends StatelessWidget {
  final String utc;
  final String city;
  final String time;
  final bool isNight;
  final bool isSelected;

  const CardTimeWidget({
    super.key,
    required this.utc,
    required this.city,
    required this.time,
    required this.isNight,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    int hour = 0;
    if (time.length >= 2) {
      hour = int.tryParse(time.substring(0, 2)) ?? 0;
    }
    final bool isNight = hour >= 18 || hour < 6;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isNight ? const Color.fromARGB(255, 0, 0, 0) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                utc,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                city,
                style: TextStyle(
                  fontSize: 20,
                  color: isNight ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // alinea arriba
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w400,
                    color: isNight ? Colors.white : Colors.black,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(
                    0,
                    8,
                  ), // ajusta para subir/bajar el ícono
                  child: Transform.flip(
                    flipX: true,
                    child: Icon(
                      isNight ? Icons.dark_mode : Icons.wb_sunny,
                      size: 20, // ícono más pequeño, como en la imagen
                      color: isNight ? Colors.yellow[700] : Colors.yellow[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
