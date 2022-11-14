import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_places_app/providers/wonderful_places.dart';

import 'add_list_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<WonderfulPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<WonderfulPlaces>(
                  child: Center(
                    child: Text("Cot no places yet, Start adding some!"),
                  ),
                  builder: (ctx, placesProvider, ch) {
                    return ListView.builder(
                      itemCount: placesProvider.items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(placesProvider.items[index].image),
                          ),
                          title: Text(placesProvider.items[index].title),
                        );
                      },
                    );
                  },
                ),
        ));
  }
}
