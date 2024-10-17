import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/bloc/notes_bloc/note_bloc.dart';
import '../../../../data/bloc/notes_bloc/note_events.dart';
import '../../../../domain/models/note_model/note_model.dart';
import '../../text_field/text_field.dart';

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
      noteTitleController.text = currNotesTitle;
      noteDescController.text = currNotesDesc;

      return ListView(
        children: [
          Text(
            isUpdate ? "Update Note!" : "Add New Note!",
            style: Theme.of(context).textTheme.headlineSmall,
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../data/bloc/notes_bloc/note_bloc.dart';
// import '../../../../data/bloc/notes_bloc/note_events.dart';
// import '../../../../domain/models/note_model/note_model.dart';
// import '../../text_field/text_field.dart';

// void showCustomBottomSheet(BuildContext context,
//     {required TextEditingController noteTitleController,
//     required TextEditingController noteDescController,
//     String currNotesTitile = "",
//     String currNotesDesc = "",
//     required NoteModel isUpdateNoteModel,
//     String isUpdateNoteId = "",
//     required bool isUpdate}) {
//   showModalBottomSheet(
//     useSafeArea: true,
//     isDismissible: true,
//     enableDrag: true,
//     showDragHandle: true,
//     sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
//     constraints: const BoxConstraints(maxWidth: double.infinity),
//     context: context,
//     builder: (context) {
//       return ListView(
//         children: [
//           Text(
//             isUpdate ? "Update Note!" : "Add New Note!",
//             style: Theme.of(context).textTheme.headlineSmall,
//             textAlign: TextAlign.center,
//           ),
//           CustomTextField(
//               mtController: noteTitleController,
//               mHindText: "Note title",
//               mPreIcon: CupertinoIcons.pencil_circle_fill,
//               mKeyboardtype: TextInputType.text),
//           CustomTextField(
//               mtController: noteDescController,
//               mHindText: "Note Description",
//               mPreIcon: CupertinoIcons.pencil_circle_fill,
//               mKeyboardtype: TextInputType.text),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: ElevatedButton(
//                         onPressed: () async {
//                           if (noteTitleController.text.isNotEmpty &&
//                               noteDescController.text.isNotEmpty) {
//                             if (isUpdate) {
//                               currNotesTitile = noteTitleController.text;
//                               currNotesDesc = noteDescController.text;

//                               BlocProvider.of<NoteBloc>(context).add(
//                                   UpdateNoteEvent(
//                                       updateNote: isUpdateNoteModel,
//                                       noteId: isUpdateNoteId));

//                               noteTitleController.clear();
//                               noteDescController.clear();
//                               Navigator.pop(context);
//                             } else {
//                               BlocProvider.of<NoteBloc>(context).add(
//                                   AddNoteEvent(addNote: isUpdateNoteModel));

//                               noteTitleController.clear();
//                               noteDescController.clear();
//                               Navigator.pop(context);

//                               const AlertDialog(
//                                 title: Text("Warning"),
//                                 content: Text("fill the all details"),
//                               );
//                             }
//                           } else {
//                             Navigator.pop(context);
//                           }
//                         },
//                         child: Text(isUpdate ? "Update Note" : "Add Note"))),
//                 SizedBox(
//                   width: 10.h,
//                 ),
//                 Expanded(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Cancel"))),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }





// ElevatedButton(
//                         onPressed: () async {
//                           if (noteTitleController.text.isNotEmpty &&
//                               noteDescController.text.isNotEmpty) {
//                             var newNote = NoteModel(
//                                 noteDes: noteDescController.text,
//                                 noteTime: DateTime.now()
//                                     .millisecondsSinceEpoch
//                                     .toString(),
//                                 noteTitle: noteTitleController.text);
//                             BlocProvider.of<NoteBloc>(context)
//                                 .add(AddNoteEvent(addNote: newNote));

//                             noteTitleController.clear();
//                             noteDescController.clear();
//                             Navigator.pop(context);
//                           } else {
//                             Navigator.pop(context);

//                             // const AlertDialog(
//                             //   title: Text("Warning"),
//                             //   content: Text("fill the all details"),
//                             // );
//                           }
//                         },
//                         child: const Text("Add Note"))





// showModalBottomSheet(
//               useSafeArea: true,
//               isDismissible: true,
//               enableDrag: true,
//               showDragHandle: true,
//               sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
//               constraints: const BoxConstraints(maxWidth: double.infinity),
//               context: context,
//               builder: (context) {
//                 return ListView(
//                   children: [
//                     Text(
//                       "Add New Note!",
//                       style: Theme.of(context).textTheme.headlineMedium,
//                       textAlign: TextAlign.center,
//                     ),
//                     CustomTextField(
//                         mtController: noteTitleController,
//                         mHindText: "Note title",
//                         mPreIcon: CupertinoIcons.pencil_circle_fill,
//                         mKeyboardtype: TextInputType.text),
//                     CustomTextField(
//                         mtController: noteDescController,
//                         mHindText: "Note Description",
//                         mPreIcon: CupertinoIcons.pencil_circle_fill,
//                         mKeyboardtype: TextInputType.text),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: ElevatedButton(
//                                   onPressed: () async {
//                                     if (noteTitleController.text.isNotEmpty &&
//                                         noteDescController.text.isNotEmpty) {
//                                       var newNote = NoteModel(
//                                           noteDes: noteDescController.text,
//                                           noteTime: DateTime.now()
//                                               .millisecondsSinceEpoch
//                                               .toString(),
//                                           noteTitle: noteTitleController.text);
//                                       BlocProvider.of<NoteBloc>(context)
//                                           .add(AddNoteEvent(addNote: newNote));

//                                       noteTitleController.clear();
//                                       noteDescController.clear();
//                                       Navigator.pop(context);
//                                     } else {
//                                       Navigator.pop(context);

//                                       // const AlertDialog(
//                                       //   title: Text("Warning"),
//                                       //   content: Text("fill the all details"),
//                                       // );
//                                     }
//                                   },
//                                   child: const Text("Add Note"))),
//                           SizedBox(
//                             width: 10.h,
//                           ),
//                           Expanded(
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text("Cancel"))),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
