import 'package:flutter/material.dart';
import 'recipe.dart';
import 'detail.dart';
import 'database.dart';
import 'main.dart';

class ReadScreen extends StatefulWidget {
  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your awesome recipes'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: DatabaseHelper.instance.retrieveRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                background(),
                ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        snapshot.data[index].title,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () =>
                          _navigateToDetail(context, snapshot.data[index]),
                      trailing: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.pinkAccent),
                          onPressed: () async {
                            _deleteRecipe(snapshot.data[index]);
                            setState(() {});
                          }),
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

_deleteRecipe(Recipe recipe) {
  DatabaseHelper.instance.deleteRecipe(recipe.id);
}

_navigateToDetail(BuildContext context, Recipe recipe) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailScreen(recipe: recipe)),
  );
}
