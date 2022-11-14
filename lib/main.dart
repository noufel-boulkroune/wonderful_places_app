import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wonderful_places.dart';
import '/screens/places_list_screen.dart';
import 'screens/add_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WonderfulPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {AddPlaceScreen.routeName: (context) => AddPlaceScreen()},
      ),
    );
  }
}
