import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
            TextField(
              //so we have a textfield widget that takes a decoration type InputDecoration
              //and the inside border is even assigned an inputborder, unlike the Border.all in containers
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type something...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
