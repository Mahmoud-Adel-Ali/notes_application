



import 'package:flutter/material.dart';
import 'package:notes/views/widget/custom_notes_item_card.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const NoteItemCard();
        },
      ),
    );
  }
}
