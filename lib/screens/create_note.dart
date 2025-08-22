import 'package:flutter/material.dart';
import 'package:notes_app/db/notes_database.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool isLoading = false;

  //save function
  Future<void> saveNote() async {
    //1- creating the vars carrying the controllers .text values.
    final title = _titleController.text;
    final content = _contentController.text;
    print("$title and $content");

    //2- Fields validation part
    if (title.isEmpty || content.isEmpty) {
      //and we have a new widget
      //->> scaffoldmessenger.of(context)
      //just like bdayet lnavigator
      //navigator >>
      //snackbar >> .showSnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all the required fields")),
      );
      return;
    }
    //3- Visual UI showing the loading state whilst saving the note
    //3.1- toggling the loading flag
    setState(() {
      isLoading = true;
    });

    //4- creating the object (note) using the model's constructor to pass the .text (vars) values.
    final note = Note(
      content: content,
      createdAt: DateTime.now(),
      title: title,
    );

    //5- Using the DB creation function to pass the created object.
    await NotesDatabase.instance.createNote(note);

    //6- popping out to show the previous stacked page.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: () {
              saveNote();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(
                // this controls the user’s input
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  // this controls only the placeholder
                  color: Colors.grey.shade400,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
            TextField(
              style: TextStyle(
                // this controls the user’s input
                color: Colors.black,
                fontSize: 25,
              ),
              controller: _contentController,
              //so we have a textfield widget that takes a decoration type InputDecoration
              //and the inside border is even assigned an inputborder, unlike the Border.all in containers
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type something...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
