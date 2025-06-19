import 'package:flutter/material.dart';
import 'package:sqfilte_flutter_application/home.dart';
import 'package:sqfilte_flutter_application/sqlDb.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final id;
  final color;

  const EditNotes({super.key, this.note, this.title, this.id, this.color});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notes'),
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
                      // int response = await sqlDb.updateData('''
                      //     UPDATE notes SET
                      //     note  = "${note.text}" ,
                      //     title = "${title.text}" ,
                      //     color = "${color.text}"
                      //     WHERE id = ${widget.id}
                      // ''');

                      int response = await sqlDb.update(
                          "notes",
                          {
                            "note": "${note.text}",
                            "color": "${color.text}",
                            "title": "${title.text}",
                          },
                          "id = ${widget.id}");

                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      }
                      // print("response================");
                      // print(response);
                    },
                    child: Text("Edit Note"),
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
