

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/presentation/features/edit_note.dart';

import '../../bloc/note_cubit.dart';
import '../../data/model/note_model.dart';

class NoteItem extends StatefulWidget {
  final NoteModel note;
  NoteItem({Key? key,required this.note}) : super(key: key);

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {

  final _random = Random();
  List<Color> mycolors=[Colors.purple,Colors.blue,Colors.indigoAccent,Colors.pink,Colors.teal,Colors.orange];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: mycolors[_random.nextInt(mycolors.length)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text(widget.note.title!,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
               Row(children: [
                 IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditNote(note: widget.note),));}, icon: const Icon(Icons.edit,) ),
                 IconButton(onPressed: (){BlocProvider.of<NoteCubit>(context).deleteData(widget.note.id!);}, icon: const Icon(Icons.delete,) ),

               ],)
          ],
        ),
         Container(
           height: 75,
           child: Text(widget.note.content!,
            style: TextStyle(fontSize: 12,),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,),
         ),
        Align(
            alignment: Alignment.bottomRight,
            child: IconButton(onPressed: (){

              if(widget.note.isaFavorite==0) {

                BlocProvider.of<NoteCubit>(context).updateFav(1, (widget.note.id)!);

              } else {
                BlocProvider.of<NoteCubit>(context).updateFav(0, (widget.note.id)!);
              }
            }, icon: Icon(Icons.favorite,color: widget.note.isaFavorite==0? Colors.white:Colors.red) )),

        ],
      ),
    ),
    );
  }
  }



