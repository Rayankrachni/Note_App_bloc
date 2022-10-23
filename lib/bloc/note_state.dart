part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class LoadingState extends NoteState {}

class AllLoadedState extends NoteState {
  final List<NoteModel> allNotes;
  final List<NoteModel> favNotes;
  //final List<NoteModel> favtasks;
  AllLoadedState(this.allNotes,this.favNotes);
}

class FavLoadedState extends NoteState {
 // final List<NoteModel> allNotes;
  final List<NoteModel> favtasks;
  FavLoadedState(this.favtasks);
}

class NotesInViewState extends NoteState {
  NotesInViewState(this.inList);
  bool inList = true;
}
class NotesUpdateDbState extends NoteState {}
class ChangeModeState extends NoteState {}
class NotesInsertDbState extends NoteState {

}
class NotesDeleteDbState extends NoteState {}