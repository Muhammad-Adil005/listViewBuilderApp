import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview_builder/season/model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Listview Builder App'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 50,
          itemBuilder: (BuildContext context, index) {
            return const ListTile(
              leading: Icon(Icons.menu_rounded),
              title: Text('Title'),
              subtitle: Text('Sub Title'),
            );
          }),
    );
  }
}

class LeaguesScreen extends StatefulWidget {
  @override
  _LeaguesScreenState createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  List<Leagues> leagues = [];

  @override
  void initState() {
    super.initState();
    fetchLeagues();
  }

  Future<void> fetchLeagues() async {
    final response = await http.get(Uri.parse(
        'https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard?limit=1000&dates=2023'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['leagues'];
      print('API Response: $data'); // Print the API response to debug
      setState(() {
        leagues = data.map((json) => Leagues.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load leagues');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leagues'),
      ),
      body: leagues.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                final league = leagues[index];
                return ListTile(
                  leading: league.logos != null && league.logos!.isNotEmpty
                      ? Image.network(
                          league.logos!.first.href!,
                          width: 50,
                          height: 50,
                        )
                      : const Icon(Icons.image),
                  title: Text(league.name ?? 'Unknown League'),
                  subtitle: Text(
                    'Abbreviation: ${league.abbreviation ?? 'N/A'}\nYear: ${league.season?.year?.toString() ?? 'No Year'}',
                  ),
                  trailing: Text(league.id ?? ''),
                );
              },
            ),
    );
  }
}
