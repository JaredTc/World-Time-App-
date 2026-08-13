import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:world_time_app/config/text/strings.dart';

class TimeProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _myCities = [
    {'city': 'Tokyo', 'utc': 'UTC+9', 'timezone': 'Asia/Tokyo'},
    {'city': 'Sydney', 'utc': 'UTC+11', 'timezone': 'Australia/Sydney'},
    {'city': 'Los Angeles', 'utc': 'UTC-8', 'timezone': 'America/Los_Angeles'},
    {'city': 'New York', 'utc': 'UTC-5', 'timezone': 'America/New_York'},
    {'city': 'London', 'utc': 'UTC+0', 'timezone': 'Europe/London'},
  ];
  List<Map<String, dynamic>> get myCities => _myCities;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TimeProvider() {
    _initData();
  }

  Future<void> _initData() async {
    _isLoading = true;
    notifyListeners();

    for (int i = 0; i < _myCities.length; i++) {
      await _fetchTimeForIndex(i, _myCities[i]['timezone']);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _fetchTimeForIndex(int index, String regionName) async {
    try {
      final res = await http.get(
        Uri.parse('${AppStrings.timeZonePath}$regionName'),
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final String localTimeFull = data['local_time'];
        final String extractedTime = localTimeFull.substring(
          11,
          16,
        ); // Ej: "15:12"

        // Calculamos el UTC offset correctamente (maneja negativos y positivos)
        final int offsetSeconds = data['current_utc_offset_seconds'];
        final int offsetHours = offsetSeconds ~/ 3600;
        final String utcSign = offsetHours >= 0
            ? '+$offsetHours'
            : '$offsetHours';

        _myCities[index]['time'] = extractedTime;
        _myCities[index]['utc'] = 'UTC$utcSign';
      }
    } catch (e) {
      print('Error al cargar hora para $regionName: $e');
    }
  }

  Future<void> addCity(String regionName, String CityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await http.get(
        Uri.parse('${AppStrings.timeZonePath}$regionName'),
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        final String localTimeFull = data['local_time'];
        final String extractedTime = localTimeFull.substring(
          11,
          16,
        ); // Ej: "15:12"

        final index = _myCities.indexWhere((c) => c['timezone'] == regionName);

        if (index != -1) {
          _myCities[index]['time'] = extractedTime;
          _myCities[index]['utc'] =
              'UTC+${data['current_utc_offset_seconds'] ~/ 3600}';
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load time data');
      }
    } catch (e) {
      print('Error occurred while adding city: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAllTimes() async {
    print('--- INICIANDO RECARGA DE HORAS ---');
    _isLoading = true;
    notifyListeners();

    for (int i = 0; i < _myCities.length; i++) {
      await _fetchTimeForIndex(i, _myCities[i]['timezone']);
    }

    _isLoading = false;
    notifyListeners();
    print('--- RECARGA FINALIZADA ---');
  }
}
