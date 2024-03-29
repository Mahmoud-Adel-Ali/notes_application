// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes/model/note_model.dart';
import 'package:notes/views/widget/custom_buttom.dart';
import 'package:notes/views/widget/custom_text_field.dart';

class AddNoteButtomSheet extends StatelessWidget {
  const AddNoteButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteFailure) {
            debugPrint("Faile : ${state.errMessage}");
          }
          if (state is AddNoteSuccess) {
            BlocProvider.of<NotesCubit>(context).fetchAllNotes();
            Navigator.pop(context);
          }
        },
        builder: (context, state) => AbsorbPointer(
          absorbing: state is AddNoteLoading ? true : false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(child: AddNoteForm()),
          ),
        ),
      ),
    );
  }
}

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  // use to validat form input
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  //
  String? title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          SizedBox(height: 16),
          CustomTextField(
            onSaved: (value) {
              title = value;
            },
            hint: 'Title',
            maxLine: 1,
          ),
          SizedBox(height: 12),
          CustomTextField(
              onSaved: (value) {
                subTitle = value;
              },
              hint: "Content",
              maxLine: 5),
          SizedBox(height: 32),
          // Spacer(),
          BlocBuilder<AddNoteCubit, AddNoteState>(builder: (context, state) {
            return CustomButtom(
              isLoading: state is AddNoteLoading ? true : false,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  var currentDate = DateTime.now();
                  var formattedDate =
                      DateFormat('dd-mm-yyyy').format(currentDate);
                  NoteModel noteModel = NoteModel(
                      title: title!,
                      subTitle: subTitle!,
                      date: formattedDate,
                      color: Colors.blue.value);
                  BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                  debugPrint("success---------------");
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            );
          }),
          // SizedBox(height: 16),
        ],
      ),
    );
  }
}
