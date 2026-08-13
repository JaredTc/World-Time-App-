import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_time_app/config/text/strings.dart';
import 'package:world_time_app/providers/time_provider.dart';
import 'package:world_time_app/widgets/bar_navigation.dart';
import 'package:world_time_app/widgets/card_time_wiget.dart';
import 'package:world_time_app/widgets/header_cards.dart';

class ListTimeScreen extends StatelessWidget {
  const ListTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              HeadersCardWidget(),
              const SizedBox(height: 24),

              // 2. Título principal
              const Text(
                AppStrings.appTitle,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Consumer<TimeProvider>(
                  builder: (context, provider, child) {
                    print('Loading: ${provider.isLoading}');
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    }
                    // if (provider.isLoading &&
                    //     provider.myCities.any((c) => c['time'] == null)) {
                    //   return const Center(
                    //     child: CircularProgressIndicator(color: Colors.black),
                    //   );
                    // }
                    return ListView.builder(
                      itemCount: provider.myCities.length,
                      itemBuilder: (context, index) {
                        final city = provider.myCities[index];
                        return CardTimeWidget(
                          utc: city['utc'],
                          city: city['city'],
                          time: city['time'] ?? '--:--',
                          isNight:
                              false, // Aquí puedes determinar si es de noche según la hora
                        );
                      },
                    );
                  },
                ),
              ),

              BarNavigateWidget(), // Barra de navegación en la parte inferior
            ],
          ),
        ),
      ),
    );
  }
}
