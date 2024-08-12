import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<Event>> _events;
  late List<Event> _selectedEvents;
  late DateTime _selectedDay;
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _events = {
      DateTime.utc(2024, 8, 5): [
        Event(
            title: 'Event 1',
            date: DateTime.utc(2024, 8, 5),
            price: Price(10.0)),
      ],
      DateTime.utc(2024, 8, 8): [
        Event(
            title: 'Event 2',
            date: DateTime.utc(2024, 8, 8),
            price: Price(20.0)),
      ],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  void _addEvent() {
    final title = _eventController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (title.isNotEmpty) {
      setState(() {
        if (_events[_selectedDay] == null) {
          _events[_selectedDay] = [];
        }
        _events[_selectedDay]!
            .add(Event(title: title, date: _selectedDay, price: Price(price)));
        _selectedEvents = _events[_selectedDay]!;
        _eventController.clear();
        _priceController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: const Text('Table Calendar Example'),
          ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              eventLoader: (day) => _events[day] ?? [],
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _selectedEvents = _events[selectedDay] ?? [];
                });
              },
              onPageChanged: (focusedDay) {
                _selectedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _eventController,
                decoration: const InputDecoration(
                  labelText: 'Enter event title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16 ,right: 16,bottom: 20),
              child: TextField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Enter event price',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _addEvent,
                child: const Text('Add Event'),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 200.0, // Set a fixed height for the ListView
              child: ListView.builder(
                itemCount: _selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = _selectedEvents[index];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    leading: const Icon(
                      Icons.event,
                      color: Colors.blue,
                    ),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: event.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' - \$${event.price?.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final DateTime date;
  final Price? price;

  Event({
    required this.title,
    required this.date,
    this.price,
  });
}

class Price {
  final double amount;

  Price(this.amount);
}

bool isSameDay(DateTime? d1, DateTime? d2) {
  if (d1 == null || d2 == null) {
    return false;
  }
  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}
