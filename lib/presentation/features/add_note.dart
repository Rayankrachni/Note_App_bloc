import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/bloc/note_cubit.dart';
import 'package:untitled5/presentation/home_screen/HomeScreen.dart';



class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        NoteCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(child: Text("Add Notes", style: TextStyle(color: Colors.white, fontSize: 25),)),
          ),
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.04,),
                    const Text(" Title", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: height * 0.03,),
                    Container(

                      height: 55,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration:const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.black,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        controller: titleController,
                      ),
                    ),
                    SizedBox(height: height * 0.03,),
                    const Text(" Content", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: height * 0.03,),
                    Container(

                      height: 250,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'enter the content';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.black),
                        decoration:const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: 10,
                        controller: contentController,
                      ),
                    ),
                    SizedBox(height: height * 0.05,),
                    Center(
                      child: SizedBox(
                        height: height * 0.075,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              cubit.insertToDb(titleController.text, contentController.text, 0,
                              ).then((value){
                                Navigator.pushReplacement(context,MaterialPageRoute(
                                  builder:(context)=>  const HomeScreen(),
                                ),
                                );
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(

                            primary: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              // <-- Radius
                            ),
                          ),
                          child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
