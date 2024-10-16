import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_events.dart';
import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_states.dart';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBloc extends Bloc<NoteEvents, NoteStates> {
  FirebaseProvider firebaseProvider;
  NoteBloc({required this.firebaseProvider}) : super(NoteIntitialState()) {
    on<AddNoteEvent>(
      (event, emit) async {
        emit(NoteLoadingState());

        try {
          await FirebaseProvider.addNote(event.addNote);
          emit(NoteLoadedState());
        } catch (e) {
          emit(NoteErrorState(noteErrorMsg: e.toString()));
        }
      },
    );
  } //
}