import 'package:flutter/material.dart';
import 'database.dart';
import 'recipe.dart';
import 'main.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detailScreen';
  final Recipe recipe;

  const DetailScreen({Key key, this.recipe}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateState(recipe);
}

class _CreateState extends State<DetailScreen> {
  Recipe recipe;
  final descriptionTextController = TextEditingController();
  final titleTextController = TextEditingController();

  _CreateState(this.recipe);

  @override
  void initState() {
    super.initState();
    if (recipe != null) {
      descriptionTextController.text = recipe.content;
      titleTextController.text = recipe.title;
    }
  }

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
    titleTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new dish'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Stack(
        children: <Widget>[
          background(),
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      labelText: 'Name of the dish'),
                  maxLines: 1,
                  controller: titleTextController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      labelText: "Ingredients & steps"),
                  maxLines: 15,
                  controller: descriptionTextController,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done_outline, size: 30,),
          onPressed: () async {
            _saveRecipe(titleTextController.text, descriptionTextController.text);
            setState(() {});
          }),
    );
  }

  _saveRecipe(String title, String content) async {
    if (recipe == null) {
      DatabaseHelper.instance.insertRecipe(Recipe(
          title: titleTextController.text,
          content: descriptionTextController.text));
      Navigator.pop(context, "Your recipe has been saved.");
    } else {
      await DatabaseHelper.instance
          .updateRecipe(Recipe(id: recipe.id, title: title, content: content));
      Navigator.pop(context);
    }
  }
}
