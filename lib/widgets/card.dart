import 'package:flutter/material.dart';
import '../models/borrow_lend.dart';

class CardExpense extends StatelessWidget {
  const CardExpense({
    super.key,
    required this.task,
    required this.onDelete,
    required this.colour,
  });

  final Task task;
  final Color colour;
  final VoidCallback onDelete;

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: colour,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        title: Text(
          task.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.currency_rupee_outlined,
                  size: 17,
                  color: Colors.blue.shade600,
                ),
                const SizedBox(width: 5),
                Text(
                  '${task.amount}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.blue.shade600,
                ),
                const SizedBox(width: 5),
                Text(
                  '${formatDate(task.date)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red.shade400,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
