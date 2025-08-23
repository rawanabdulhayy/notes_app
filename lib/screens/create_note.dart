import 'package:flutter/material.dart';
import 'package:notes_app/db/notes_database.dart';

class CreateNote extends StatefulWidget {
  //A- we only ever send this on editing a note.
  final Note? note;
  const CreateNote({super.key, this.note});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  //can I even have a late final together?
  //he says yes, because it's a final, not gonna change but haven't yet been assigned any values.
  //yet the problem here was related to having had two different definitions (= TextEditingController())
  //one in initState and the one underneath.
  late TextEditingController _titleController;
  late TextEditingController _contentController;

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
      id: widget.note!.id,
      content: content,
      title: title,
      createdAt: widget.note?.createdAt ?? DateTime.now(),
    );

    //C- accounting for either editing or creating a new note
    //a7na bnb3t Note note only when we add a new note via el floating action button, that's when we send the parameter through the constructor.

    if (widget.note != null) {
      await NotesDatabase.instance.updateNotes(note);
    } else {
      //5- >> D- Using the DB creation function to pass the created object.
      await NotesDatabase.instance.createNote(note);
    }
    //6- popping out to show the previous stacked page.
    // *** Child screen (CreateNote):
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    //B- 3ayza awl mft7 l-screen, the data from the note opened shows up, not like a newly created note fashion, bas in an edit note style.
    //widget here reflects the widget above in context, here it's the CreateNote, because _CreateNoteState can't use CreateNote's property unless explicitly referenced by widget.something
    _titleController = TextEditingController(text: widget.note?.title);
    _contentController = TextEditingController(text: widget.note?.content);
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
