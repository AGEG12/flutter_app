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
              TextFormField(
                initialValue: _title,
                decoration:
                    const InputDecoration(labelText: 'Título de la película'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _director,
                decoration:
                    const InputDecoration(labelText: 'Director de la película'),
                onSaved: (value) => _director = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre del director';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _yearOfRelease.toString(),
                decoration:
                    const InputDecoration(labelText: 'Año de lanzamiento'),
                onSaved: (value) =>
                    _yearOfRelease = int.tryParse(value ?? '') ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el año de lanzamiento';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _genre,
                decoration:
                    const InputDecoration(labelText: 'Género de la película'),
                onSaved: (value) => _genre = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el género de la película';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _synopsis,
                decoration:
                    const InputDecoration(labelText: 'Sinopsis de la película'),
                maxLines: 3,
                onSaved: (value) => _synopsis = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la sinopsis de la película';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _imageCover,
                decoration:
                    const InputDecoration(labelText: 'URL de la imagen de portada'),
                onSaved: (value) => _imageCover = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el URL de la imagen de portada';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
          .doc(widget.movieData['uid'])
          .update({
        'title': _title,
        'director': _director,
        'year_of_release': _yearOfRelease,
        'genre': _genre,
        'synopsis': _synopsis,
        'cover_image': _imageCover,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      ); // Regresar a la pantalla anterior
      // Llama a fetchData para actualizar la lista de películas
    } catch (e) {
      print('Error al guardar los cambios: $e');
    }
  }
}
