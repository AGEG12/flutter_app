import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addmovie_screen.dart';
import 'package:flutter_application_1/screens/moviedetails_screen.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// libreria firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  late List<DocumentSnapshot> moviesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('movies').get();

    setState(() {
      moviesData = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        automaticallyImplyLeading: false,
      ),
      body: moviesData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: moviesData.length,
              itemBuilder: (context, index) {
                final movie = moviesData[index].data() as Map<String, dynamic>;
                return ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(movie['title'] ?? 'No title'),
                  subtitle: Text(movie['synopsis'] ?? 'No synopsis'),
                  leading: Image.network(
                    movie['cover_image'] ?? 'https://static.vecteezy.com/system/resources/previews/004/726/030/non_2x/warning-upload-error-icon-with-cloud-vector.jpg',
                    width: 50.0,
                    height: 100.0,
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movieData: movie),
                      ),
                    );
                    },
                    child: const Text('Ver más'),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddMovieScreen()),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
    );    
  }
}




/* class _HomeScreenState extends State<HomeScreen> {
  late List<dynamic> seriesData = [];

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  Future<void> getMovies() async {
    final response = await http.get(
      Uri.parse('https://gateway.marvel.com/v1/public/series?ts=1&apikey=cc9dafea86af370e3a548d2ebe25ab37&hash=dd9649b54a37a3a821788fca9e1c94a4'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['data']['results'];
      setState(() {
        seriesData = results;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
      ),
      body: seriesData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: seriesData.length,
              itemBuilder: (context, index) {
                final series = seriesData[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(series['title']),
                  subtitle: Text(series['description'] ?? 'No description'),
                  leading: Image.network(
                    '${series['thumbnail']['path']}.${series['thumbnail']['extension']}',
                    width: 50.0,
                    height: 50.0,
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón "Ver más"
                    },
                    child: const Text('Ver más'),
                  ),
                );
              },
            ),
    );
  }
} */