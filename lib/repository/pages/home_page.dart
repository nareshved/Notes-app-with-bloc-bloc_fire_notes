import 'dart:math';

import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_bloc.dart';
import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_events.dart';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:bloc_fire_notes/domain/models/note_model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../widgets/text_field/text_field.dart';

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
            callMyBottomSheet(
              context,
              noteTitleController: noteTitleController,
              noteDescController: noteDescController,
            );
          },
          label: const Text("+  new")),
      body: StreamBuilder(
        stream: FirebaseProvider.getNotes(),
        builder: (context, snapshot) {
          // if (snapshot.data!.docs.isEmpty) {
          //   return const Center(
          //     child: Text(
          //       "Add new note first! ❤",
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   );
          //   // return Center(
          //   //   child: Column(
          //   //     children: [
          //   //       Lottie.asset("lottie/no-notes.json", fit: BoxFit.fitWidth),
          //   //       const Text(
          //   //         "Add new note first! ❤",
          //   //         style: TextStyle(fontWeight: FontWeight.bold),
          //   //       )
          //   //     ],
          //   //   ),
          //   // );
          // }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            var mData = snapshot.data!.docs;
            log(mData.length);

            return ListView.builder(
              itemCount: mData.length,
              itemBuilder: (context, index) {
                var eachDocId = mData[index].id;
                NoteModel currNotes = NoteModel.fromDoc(mData[index].data());
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Note Added Time!"),
                          content: Text(DateFormat("yMd").format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(currNotes.noteTime)))),
                        );
                      },
                    );
                  },
                  leading: const Icon(CupertinoIcons.pencil_circle_fill),
                  title: Flexible(child: Text(currNotes.noteTitle)),
                  subtitle: Flexible(child: Text(currNotes.noteDes)),
                  trailing: SizedBox(
                    width: 100,
                    child: Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                callMyBottomSheet(context,
                                    isUpdate: true,
                                    currNotesDesc: currNotes.noteDes,
                                    currNotesTitle: currNotes.noteTitle,
                                    noteTitleController: noteTitleController,
                                    noteDescController: noteDescController,
                                    isUpdateNoteId: eachDocId);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Delete Note!"),
                                    content: const Text(
                                        "Are you sure to delete Note!"),
                                    actions: [
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        label: const Text("Cancel"),
                                        icon: const Icon(Icons.cancel),
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          BlocProvider.of<NoteBloc>(context)
                                              .add(DeleteNoteEvent(
                                                  noteId: eachDocId));

                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("note deleted!"),
                                          ));
                                        },
                                        label: const Text("Delete"),
                                        icon: const Icon(
                                          CupertinoIcons.delete,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                CupertinoIcons.delete,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("no Notes!"));
        },
      ),
    );
  }

  void callMyBottomSheet(BuildContext context,
      {required TextEditingController noteTitleController,
      required TextEditingController noteDescController,
      String currNotesTitle = "",
      String currNotesDesc = "",
      // required NoteModel isUpdateNoteModel,
      String isUpdateNoteId = "",
      bool isUpdate = false}) {
    if (isUpdate) {
      noteTitleController.text = currNotesTitle;
      noteDescController.text = currNotesDesc;
    } else {
      noteTitleController.text = "";
      noteDescController.text = "";
    }
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
              isUpdate ? "Update Note!" : "Add New Note!",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            CustomTextField(
                obs: false,
                mtController: noteTitleController,
                mHindText: "Note title",
                mPreIcon: CupertinoIcons.pencil_circle_fill,
                mKeyboardtype: TextInputType.text),
            CustomTextField(
                obs: false,
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
                            // update note here

                            if (isUpdate) {
                              var newNote = NoteModel(
                                  noteDes: noteDescController.text,
                                  noteTime: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  noteTitle: noteTitleController.text);

                              BlocProvider.of<NoteBloc>(context).add(
                                  UpdateNoteEvent(
                                      updateNote: newNote,
                                      noteId: isUpdateNoteId));

                              noteTitleController.clear();
                              noteDescController.clear();
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("note Updated!"),
                              ));
                            } else {
                              if (noteTitleController.text.isNotEmpty &&
                                  noteDescController.text.isNotEmpty) {
                                var newNote = NoteModel(
                                    noteDes: noteDescController.text,
                                    noteTime: DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    noteTitle: noteTitleController.text);
                                BlocProvider.of<NoteBloc>(context)
                                    .add(AddNoteEvent(addNote: newNote));

                                noteTitleController.clear();
                                noteDescController.clear();
                                Navigator.pop(context);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("note added!"),
                                ));
                              }
                            }
                          },
                          child: Text(isUpdate ? "Update Note" : "Add Note"))),
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
  }
}
