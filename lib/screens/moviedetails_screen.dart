import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/editmovie_screen.dart';


class MovieDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> movieData;

  const MovieDetailsScreen({super.key, required this.movieData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieData['title'] ?? 'Detalles de la película'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movieData['cover_image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/726/030/non_2x/warning-upload-error-icon-with-cloud-vector.jpg',
              height: 450.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text('Año de lanzamiento: ${movieData['year_of_release']}'),
            Text('Género: ${movieData['genre']}'),
            Text('Director: ${movieData['director']}'),
            Text('Sinopsis: ${movieData['synopsis']}'),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresar al listado
                  },
                  child: const Text('Regresar al listado'),
                ),
                ElevatedButton(
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMovieScreen(movieData: widget.movieData),
                      ),
                    );
                  },
                  child: const Text('Editar película'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
