import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_places_app/providers/wonderful_places.dart';
import 'package:wonderful_places_app/widgets/location_inout.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = "add-place-screen";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleControler = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleControler.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ], content: Text("Pleas enter the title")),
      );
      return;
    } else if (_pickedImage == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ], content: Text("Pleas tacke an image")),
      );
      return;
    }
    Provider.of<WonderfulPlaces>(context, listen: false).addPlace(
        pickedTitle: _titleControler.text, pickedImage: _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleControler,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ImageInput(
                    selectedImage: _selectImage,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LocationInput(),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor:
                  MaterialStatePropertyAll(Theme.of(context).accentColor),
            ),
            label: Text("Add Place"),
            onPressed: () {
              _savePlace();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
