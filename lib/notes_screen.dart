import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    //When do I declare stuff here under the build and when do I declare outside of the build?
    // --> Declare inside build() if the variable depends on something that can change on every rebuild
    //     (like MediaQuery size, theme colors, or freshly fetched data).
    //     Declare outside build() (as a field in the State class) if the value is persistent
    //     across rebuilds and doesn’t depend on the current build context (e.g., controllers, fixed data lists).

    //we don't have to specify the list and it's objects type?
    //e.g. list<Map <String, String>>
    //Nope, implicitly assigned the type
    // --> True for small/local cases; Dart infers the type from the data you put inside.
    //     But in larger codebases, explicitly typing (List<Map<String, dynamic>>) helps catch errors earlier.

    final notes = [
      {
        "title": "Grocery List",
        "content":
            "Eggs, milk, bread, olive oil, coffee beans, bananas, peanut butter.",
        "createdAt": DateTime.now().subtract(Duration(minutes: 10)),
      },
      {
        "title": "Workout Plan",
        "content":
            "Monday: Push\nTuesday: Pull\nWednesday: Legs\nThursday: Yoga\nFriday: Cardio",
        "createdAt": DateTime.now().subtract(Duration(hours: 2)),
      },
      {
        "title": "Flutter Ideas",
        "content":
            "Try adding dark mode toggle, use Riverpod for state management, explore animations package.",
        "createdAt": DateTime.now().subtract(Duration(days: 1)),
      },
      {
        "title": "Meeting Notes",
        "content":
            "Discussed new app features: onboarding flow, search improvements, bug fixes, and push notifications.",
        "createdAt": DateTime.now().subtract(Duration(days: 2)),
      },
      {
        "title": "Book Quotes",
        "content":
            "\"It is not the strongest of the species that survive, but the most adaptable.\" — Charles Darwin",
        "createdAt": DateTime.now().subtract(Duration(days: 3, hours: 5)),
      },
      {
        "title": "Recipe",
        "content":
            "Spaghetti Aglio e Olio: spaghetti, garlic, olive oil, red pepper flakes, parsley, parmesan.",
        "createdAt": DateTime.now().subtract(Duration(days: 4)),
      },
      {
        "title": "Travel Checklist",
        "content":
            "Passport, tickets, power bank, travel pillow, adapters, sunglasses, sunscreen.",
        "createdAt": DateTime.now().subtract(Duration(days: 5)),
      },
      {
        "title": "Random Thoughts",
        "content":
            "What if we could save UI state to JSON and reload it like a snapshot?",
        "createdAt": DateTime.now().subtract(Duration(days: 7, hours: 3)),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          // This is a good reminder for using such ternary operator to build the UI based on such a conditional check.
         //e.g. var.isEmpty? WIDGET1 : WIDGET2
          notes.isEmpty
              ? Center(
                child: Text(
                  'No notes yet',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  // ---- SO IMPORTANT ----
                  itemCount: notes.length,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: (context, index) {
                    // ---- SO IMPORTANT ----
                    final note = notes[index];
                    return Container(
                      //containers have their own padding properties too????
                      // --> Yes, Container has its own padding property (via the 'padding' named parameter).
                      //     But if you also set decoration, that padding applies inside the decoration's border.
                      padding: EdgeInsets.all(16),
                      // Colors.primaries → a built-in list of 18 Material Design primary colors (red, pink, blue, etc.)
                      // index % Colors.primaries.length → modulo ensures the index loops back to 0 after reaching the last color
                      //     e.g., if index = 18, 18 % 18 = 0 → starts again from the first color
                      // .withValues(alpha: 0.1) → creates a copy of the color but with 10% opacity (soft pastel look)
                      // Overall: picks a color based on the note's index, loops through available colors,
                      // and makes it transparent for a lighter background effect
                      // color: Colors.primaries[index % Colors.primaries.length]
                      //     .withValues(alpha: 0.1),

                      decoration: BoxDecoration(
                        //iterating over colors as a list of colors
                        color: Colors.primaries[index % Colors.primaries.length]
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(notes["title"].toString()),
                          //So what's the difference between .toString and as String?
                          // --> .toString(): Converts any value (even null) to its string representation ("null" if null).
                          //     as String: Tells Dart to treat the value as a String (fails if it's null or not actually a String).
                          Text(
                            note["title"] as String,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          //N.B) we have more text props : overflow and maxlines.
                          Text(
                            note['content'] as String,

                            // ---- NULL SAFETY USING NULL-AWARE OPERATORS ----
                            // Text(
                            //   (note['content'] ?? '') as String,
                            // )
                            // ---- OR ----
                            // Text(note['content'] ?? '')
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          // when to use dateformat and when to use datetime? what's the difference?
                          // --> DateTime: The actual object storing a date & time value (e.g., 2025-08-15 20:31:00).
                          //     DateFormat (from intl package): A utility to convert a DateTime into a nicely formatted String (and parse strings to DateTime).
                          Text(
                            DateFormat.yMMMd().format(
                              note["createdAt"] as DateTime,
                            ),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
