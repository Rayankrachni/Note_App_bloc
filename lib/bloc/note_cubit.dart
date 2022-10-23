import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled5/core/style/themestyle.dart';

import '../core/network/local/sql_config.dart';
import '../data/model/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  List<NoteModel> allNotes=[];
  List<NoteModel> favNotes=[];
  bool ? isEmptyList;
  SqlDb sqlDb=SqlDb() ;


  List<NoteModel>getAllNotes(){
    emit(LoadingState());
    sqlDb.readDatabase().then((notes)
    {//emit= sta
      favNotes=[];
      this.allNotes=notes;
      sqlDb.readDatabase().then((notes)
      {//emit= start the state
        favNotes=[];

        this.allNotes=notes;
        notes.forEach((element) {
          if(element.isaFavorite==1)
          {
            favNotes.add(element);
          }
          emit(AllLoadedState(notes,favNotes));
        });
      });

      return [];

      emit(AllLoadedState(notes,favNotes));
    }
    );

    return [];
  }
  List<NoteModel> getFavNotes(){
    emit(LoadingState());
    sqlDb.getFavoriteNotes().then((favnotes)
    {//emit= start the state
      this.favNotes=favnotes;
      emit(FavLoadedState(favNotes));
    });

    return [];
  }

  Future insertToDb(String title,String content,int isFav)async
  {

    await sqlDb.insertDatabase(title,content,isFav);
    emit(NotesInsertDbState());
    getAllNotes();

  }
  void updateContent(String title,String content,int id)
  {

    sqlDb.updateContentDatabase(title, content, id);
    getAllNotes();
    emit(NotesUpdateDbState());

  }

  void changeMode()
  {
    ThemeServices.changeThemeMode();

    emit(ChangeModeState());

  }

  void updateFav(int isFav,int id)async
  {
    sqlDb.updateFavDatabase(isFav, id);
    getAllNotes();
    emit(NotesUpdateDbState());

  }
  void deleteData(int id)
  {
    sqlDb.deleteDatabase(id);
    getAllNotes();
    emit(NotesDeleteDbState());


  }


  void showNotesInGridEvent() {
    emit.call(NotesInViewState(true));
  }

  void showNotesInListEvent() {
    emit.call(NotesInViewState(false));
  }
}
