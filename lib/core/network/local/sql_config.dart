import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/model/note_model.dart';


class  SqlDb{

  static Database? _db;
  Future<Database?> get db async{

    if(_db==null)
    {
      _db= await initialDb();
      return _db;
    }
    else{
      return _db;
    }
  }




  initialDb() async{
    String databasepath= await getDatabasesPath();
    String path= join(databasepath,'noteApp.db');
    Database mydb= await openDatabase(path,onCreate: _onCreate,


      version: 1,);
    return mydb;
  }


  _onCreate(Database db, int version) async{
    print('on create ');
    db.execute('''CREATE TABLE Note (
    "id" INTEGER PRIMARY KEY, 
    "title" TEXT,
    "content" TEXT,
    "isFavorite" INTEGER
    )''');

  }

  readDatabase() async {
    Database? myDb= await db;
    try{
      var response=await myDb!.rawQuery('SELECT * FROM "Note" ');
      List<NoteModel> mynotes= (response).map((c) => NoteModel.fromJason(c)).toList();
      print('$response response');
      print('$mynotes mynotes');
      return mynotes;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  getFavoriteNotes() async {
    Database? myDb= await db;
    try{
      var response=await myDb!.rawQuery('SELECT * FROM "Note" WHERE "isFavorite"=1  ');
      List<NoteModel> mynotes= (response).map((c) => NoteModel.fromJason(c)).toList();
      print('$response response');
      print('$mynotes mynotes');

      return mynotes;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  insertDatabase(String title,String content,int isFav) async {
    Database? myDb= await db;
    int response= await myDb!.rawInsert("INSERT INTO 'Note' (title,content,isFavorite) VALUES (?,?,?)",[title,content,isFav]);
    print('insrted --------------');
    print('insrted $response');
    return response;
  }
  updateContentDatabase(String title,String content,int id) async {
    Database? myDb= await db;
    int response=await myDb!.rawUpdate( "UPDATE 'Note' SET content=? title=? WHERE id = ?", [content,title,id]);
    return response;

  }
  updateFavDatabase(int favorite,int id) async {
    Database? myDb= await db;
    int response=await myDb!.rawUpdate( "UPDATE 'Note' SET isFavorite=?  WHERE id = ?", [favorite,id]);
    return response;

  }

  deleteDatabase(int id) async {
    Database? myDb= await db;
    int response=await myDb!.rawDelete('DELETE  FROM "Note" WHERE "id"=$id');
    return response;

  }
}