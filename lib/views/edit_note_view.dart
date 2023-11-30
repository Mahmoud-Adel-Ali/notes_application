
import 'package:flutter/material.dart';
import 'package:notes/views/widget/edit_view_body.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: EditNoteViewBody(),
      ),
    );
  }
}