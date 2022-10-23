
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/data/model/note_model.dart';
import 'package:untitled5/presentation/widget/loaded.dart';

import '../../bloc/note_cubit.dart';
import '../widget/empty_list.dart';
import '../widget/item_List.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<NoteModel>? favlist;
  bool isListView=true;
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
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.orangeAccent) ),

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 10,),
              buildBody()

            ],
          ),
        ),
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
        favlist = (state).favNotes;
        print('notew $favlist');
        return favlist!.isEmpty? Center(child: Epmty()): _buildListOrEmpty();
      }
      else if (state is NotesInViewState) {
        isListView = (state).inList;
        print('notew $favlist');
        return _buildListOrEmpty();
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
          itemCount:favlist!.length,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: NoteItem(note: favlist![index]),
            );
          }, ))
        :Expanded(child: GridView.builder(
            itemCount: favlist?.length,
            itemBuilder: (BuildContext context,int index){
              return NoteItem(note: favlist![index]);
            }, gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
          ),));

  }
}
