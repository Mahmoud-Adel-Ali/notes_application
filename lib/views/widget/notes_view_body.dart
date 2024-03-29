import 'package:flutter/material.dart';
import 'package:notes/views/widget/custom_appbar.dart';
import 'package:notes/views/widget/notes_list_view.dart';

class NotesViewBody extends StatelessWidget {
  const NotesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Column(
      children: [
        SizedBox(height:25),
        CustomAppBar(title: 'Notes', icon: Icons.search,),
        // NoteItemCard(),
        Expanded(child: NotesListView()),
      ],
    );
  }
}
