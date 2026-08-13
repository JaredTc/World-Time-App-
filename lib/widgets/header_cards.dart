import 'package:flutter/material.dart';

class HeadersCardWidget extends StatelessWidget {
  const HeadersCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(5, (index) {
            return Container(
              margin: const EdgeInsets.only(right: 3.0),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://picsum.photos/seed/$index/200/300',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),

                blurRadius: 10,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Acción al presionar el botón
            },
          ),
        ),
      ],
    );
  }
}
