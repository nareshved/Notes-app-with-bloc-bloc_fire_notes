import 'package:bloc_fire_notes/domain/models/note_model/note_model.dart';

abstract class NoteEvents {}

class AddNoteEvent extends NoteEvents {
  NoteModel addNote;

  AddNoteEvent({required this.addNote});
}

class UpdateNoteEvent extends NoteEvents {
  NoteModel updateNote;

  UpdateNoteEvent({required this.updateNote});
}

class DeleteNoteEvent extends NoteEvents {
  String noteId;

  DeleteNoteEvent({required this.noteId});
}