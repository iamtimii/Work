import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Map<String, dynamic>> getPostById(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> users = await getUsers();
                print(users);
              },
              child: Text('Get Users'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> posts = await getPosts();
                print(posts);
              },
              child: Text('Get Posts'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                int postId = 1;
                Map<String, dynamic> post = await getPostById(postId);
                print(post);
              },
              child: Text('Get Post by ID'),
            ),
          ],
        ),
      ),
    );
  }}