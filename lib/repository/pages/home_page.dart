import 'dart:math';

import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_bloc.dart';
import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_events.dart';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:bloc_fire_notes/domain/models/note_model/note_model.dart';
import 'package:bloc_fire_notes/repository/widgets/text_field/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  final TextEditingController noteTitleController = TextEditingController();
  final TextEditingController noteDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "blocFire Notes",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              useSafeArea: true,
              isDismissible: true,
              enableDrag: true,
              showDragHandle: true,
              sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
              constraints: const BoxConstraints(maxWidth: double.infinity),
              context: context,
              builder: (context) {
                return ListView(
                  children: [
                    Text(
                      "Add New Note!",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    CustomTextField(
                        mtController: noteTitleController,
                        mHindText: "Note title",
                        mPreIcon: CupertinoIcons.pencil_circle_fill,
                        mKeyboardtype: TextInputType.text),
                    CustomTextField(
                        mtController: noteDescController,
                        mHindText: "Note Description",
                        mPreIcon: CupertinoIcons.pencil_circle_fill,
                        mKeyboardtype: TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (noteTitleController.text.isNotEmpty &&
                                        noteDescController.text.isNotEmpty) {
                                      var newNote = NoteModel(
                                          noteDes: noteTitleController.text,
                                          noteTime: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          noteTitle: noteDescController.text);
                                      BlocProvider.of<NoteBloc>(context)
                                          .add(AddNoteEvent(addNote: newNote));

                                      noteTitleController.clear();
                                      noteDescController.clear();
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context);

                                      // const AlertDialog(
                                      //   title: Text("Warning"),
                                      //   content: Text("fill the all details"),
                                      // );
                                    }
                                  },
                                  child: const Text("Add Note"))),
                          SizedBox(
                            width: 10.h,
                          ),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"))),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
          label: const Text("add new Note")),
      body: StreamBuilder(
        stream: FirebaseProvider.firebaseFireStore
            .collection("users")
            .doc(FirebaseProvider.firebaseCurrentUser)
            .collection("notes")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mData = snapshot.data!.docs;
            log(mData.length);

            return ListView.builder(
              itemCount: mData.length,
              itemBuilder: (context, index) {
                //  var eachDocId = mData[index].id;
                NoteModel currNotes = NoteModel.fromDoc(mData[index].data());
                return ListTile(
                  title: Text(currNotes.noteTitle),
                  subtitle: Text(currNotes.noteDes),
                );
              },
            );
          }
          return const Center(child: Text("no Notes!"));
        },
      ),
    );
  }
}
