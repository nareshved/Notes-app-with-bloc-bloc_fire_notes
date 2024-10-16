abstract class NoteStates {}

class NoteIntitialState extends NoteStates {}

class NoteLoadingState extends NoteStates {}

class NoteLoadedState extends NoteStates {}

class NoteErrorState extends NoteStates {
  String noteErrorMsg;

  NoteErrorState({required this.noteErrorMsg});
}
