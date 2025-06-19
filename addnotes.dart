import 'package:flutter/material.dart';
import 'package:sqfilte_flutter_application/home.dart';
import 'package:sqfilte_flutter_application/sqlDb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(
                      hintText: "notes",
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "title",
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: InputDecoration(
                      hintText: "color",
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      // int response = await sqlDb.insertData('''
                      //   INSERT INTO notes (note , title , color)
                      //   VALUES ("${note.text}" , "${title.text}" , "${color.text}")
                      // ''');
                      int response = await sqlDb.insert("notes", {
                        "note": "${note.text}",
                        "title": "${title.text}",
                        "color": "${color.text}",
                      });

                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      }
                      // print("response================");
                      // print(response);
                    },
                    child: Text("Add Note"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
