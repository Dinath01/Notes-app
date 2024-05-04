import 'package:flutter/material.dart';
import 'package:notes/assets/tile_settings.dart';
import 'package:popover/popover.dart';

class NoteList extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteList({
    super.key,
    required this.text,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
        child: ListTile(
          title: Text(text),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showPopover(context: context, bodyBuilder: (context) => noteSettings()),
          )
        ));
  }
}
