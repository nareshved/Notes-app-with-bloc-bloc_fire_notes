import 'dart:math';

import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_bloc.dart';
import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_events.dart';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:bloc_fire_notes/domain/models/note_model/note_model.dart';
import 'package:bloc_fire_notes/repository/widgets/home/update_note_bottom_sheet/update_note_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Add a note first"),
            );
          }
          if (snapshot.hasData) {
            var mData = snapshot.data!.docs;
            log(mData.length);

            return ListView.builder(
              itemCount: mData.length,
              itemBuilder: (context, index) {
                var eachDocId = mData[index].id;
                NoteModel currNotes = NoteModel.fromDoc(mData[index].data());
                return ListTile(
                  leading: const Icon(CupertinoIcons.pencil_circle_fill),
                  title: Text(currNotes.noteTitle),
                  subtitle: Text(currNotes.noteDes),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
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
                                        BlocProvider.of<NoteBloc>(context).add(
                                            DeleteNoteEvent(noteId: eachDocId));

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
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.delete,
                            )),
                      ],
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
}
