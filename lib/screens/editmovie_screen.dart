import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class EditMovieScreen extends StatefulWidget {
  final Map<String, dynamic> movieData;

  const EditMovieScreen({super.key, required this.movieData});

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _title;
  late String _director;
  late int _yearOfRelease;
  late String _genre;
  late String _synopsis;
  late String _imageCover;

  @override
  void initState() {
    super.initState();
    // Inicializa los campos con los valores actuales
    _title = widget.movieData['title'];
    _director = widget.movieData['director'];
    _yearOfRelease = widget.movieData['year_of_release'];
    _genre = widget.movieData['genre'];
    _synopsis = widget.movieData['synopsis'];
    _imageCover = widget.movieData['cover_image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Película'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (campos de entrada para cada atributo)
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    saveChanges();
                  }
                },
                child: const Text('Guardar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cancelar
                },
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveChanges() async {
    try {
      // Actualiza el documento en Firestore con los nuevos valores
      await FirebaseFirestore.instance
          .collection('movies')
          .doc(widget.movieData.id)
          .update({
        'title': _title,
        'director': _director,
        'year_of_release': _yearOfRelease,
        'genre': _genre,
        'synopsis': _synopsis,
        'cover_image': _imageCover,
      });

      Navigator.pop(context); // Regresar a la pantalla anterior
      // Llama a fetchData para actualizar la lista de películas
      //HomeScreen.fetchData();
    } catch (e) {
      print('Error al guardar los cambios: $e');
    }
  }
}
