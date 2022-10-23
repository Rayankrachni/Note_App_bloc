
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/presentation/Favorite_Screen/FavScreen.dart';
import 'package:untitled5/presentation/widget/loaded.dart';

import '../../bloc/note_cubit.dart';
import '../../data/model/note_model.dart';
import '../features/add_note.dart';
import '../features/edit_note.dart';
import '../widget/empty_list.dart';
import '../widget/item_List.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel>? allNotes;
  bool? isEmptyList;
  bool isListView=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NoteCubit>(context).getAllNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title:const Text('All Notes ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            if(isListView){context.read<NoteCubit>().showNotesInListEvent();}
            else{context.read<NoteCubit>().showNotesInGridEvent();}

          }, icon: const Icon(Icons.grid_view_rounded,color: Colors.orangeAccent,) ),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FavScreen()));
          }, icon: Icon(Icons.favorite,color: Colors.orangeAccent) ),
          IconButton(onPressed: (){
            print('change Mode');
           // BlocProvider.of<NoteCubit>(context).changeMode();
          }, icon: Icon(Icons.dark_mode,color: Colors.orangeAccent) ),

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 10,),
                  buildBody()

                ],

          ),
          ),
        ),


      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.black,
        child: Icon(Icons.add_outlined,color: Colors.white,size: 29,),
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote(),));
        // );
        },
      ),

    );
  }
  Widget buildBody() {
    return BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
        if (state is LoadingState ) {
        return  Loader(title: 'No List is Loaded yet',);
      }
      else
      if (state is AllLoadedState) {
        allNotes = (state).allNotes;
        print('notew $allNotes');
        return allNotes!.isEmpty ? Center(child: Epmty()): _buildListOrEmpty();
      }
      else   if (state is NotesInViewState) {
        isListView=(state).inList;
        return  _buildListOrEmpty();
      }


      else {
       return Loader(title: 'Updated Information',);

      }
    });
  }

  Widget _buildListOrEmpty( ) {

    return isListView ?
    Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:allNotes?.length,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: NoteItem(note: allNotes![index]),
            );
          }, ))
    :Expanded(child: GridView.builder(
      itemCount: allNotes!.length,
      itemBuilder: (BuildContext context,int index){
        return NoteItem(note: allNotes![index]);
          }, gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
        ),));

  }
}
