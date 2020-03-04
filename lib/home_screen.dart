import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = ["Fortaleza", "Maracanau", "Caucaia"];

  final recentCities = ["Fortaleza", "Maracanau"];

  @override
  String get searchFieldLabel => "Pesquisa por cidades";

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions on appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the appbar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //show me the result based on the selection
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone seaches for something
    final suggestionsList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) => ListTile(
              onTap: (){
                showResults(context);
                //açao de click no item
              },
              leading: Icon(Icons.location_city),
              //title: Text(suggestionsList[index]),
              title: RichText(
                text: TextSpan(
                  text: suggestionsList[index].substring(0, query.length),
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: suggestionsList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey),
                    )
                  ]
                )
              ),
            ));
  }
}
