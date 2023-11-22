import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:uuid/uuid.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _director = '';
  int _yearOfRelease = 0;
  String _genre = '';
  String _synopsis = '';
  String _imageCover = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Película'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Título de la película'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el título';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Director de la película'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el nombre del director';
                  }
                  return null;
                },
                onSaved: (value) {
                  _director = value!;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Año de lanzamiento'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el año de lanzamiento';
                  }
                  return null;
                },
                onSaved: (value) {
                  _yearOfRelease = int.parse(value!);
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Género de la película'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el género';
                  }
                  return null;
                },
                onSaved: (value) {
                  _genre = value!;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Sinopsis de la película'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la sinopsis';
                  }
                  return null;
                },
                onSaved: (value) {
                  _synopsis = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'URL de la imagen de portada'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la URL de la imagen de portada';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageCover = value!;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        saveMovie();
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

  Future<void> saveMovie() async {
    try {
      var uuid = const Uuid();
      String movieId = uuid.v4();
      await FirebaseFirestore.instance.collection('movies').doc(movieId).set({
        'title': _title,
        'director': _director,
        'year_of_release': _yearOfRelease,
        'genre': _genre,
        'synopsis': _synopsis,
        'uid': movieId,
        'cover_image': _imageCover,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      print('Error al guardar la película: $e');
    }
  }
}
