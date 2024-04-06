import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDotile extends StatelessWidget {
  final String taskName;
  final bool taskComlited;
  Function(bool?)? onChanged;
  Function(BuildContext)? deletefun;
  ToDotile(
      {super.key,
      required this.taskName,
      required this.taskComlited,
      required this.onChanged,
      required this.deletefun});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 20.0, top: 20.0),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deletefun,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Checkbox(
                value: taskComlited,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                    decoration: taskComlited
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(13)),
        ),
      ),
    );
  }
}
