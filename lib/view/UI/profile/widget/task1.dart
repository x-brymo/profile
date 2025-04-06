import 'package:flutter/material.dart';
import 'dart:async';
class Task1 extends StatefulWidget {
  const Task1({super.key});

  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
 List<TaskProcessCard> tasks = [];

Future<bool> getTasks() async {
  await Future.delayed(const Duration(seconds: 5));
  tasks = [
    TaskProcessCard(title: 'Task 1', processDuration: const Duration(seconds: 10)),
    TaskProcessCard(title: 'Task 2', processDuration: const Duration(seconds: 15)),
  ];
  return true;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 1'),
      ),
      body: FutureBuilder(future: getTasks() , builder: 
        (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return tasks[index];
              },
            );
          }
          
        }
      ),
    );
  }
}


class TaskProcessCard extends StatefulWidget {
  final String title;
  final Duration processDuration;

  const TaskProcessCard({required this.title, required this.processDuration, super.key});

  @override
  _TaskProcessCardState createState() => _TaskProcessCardState();
}

class _TaskProcessCardState extends State<TaskProcessCard> {
  bool isRunning = false;
  DateTime? startTime;
  DateTime? endTime;
  late Timer timer;
  double progress = 0.0;

  void startProcess() {
    setState(() {
      isRunning = true;
      startTime = DateTime.now();
      endTime = startTime!.add(widget.processDuration);
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final total = widget.processDuration.inSeconds;
      final elapsed = now.difference(startTime!).inSeconds;

      if (elapsed >= total) {
        timer.cancel();
        setState(() {
          progress = 1.0;
          isRunning = false;
        });
      } else {
        setState(() {
          progress = elapsed / total;
        });
      }
    });
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isRunning ? 1.0 : 0.3,
              child: CircularProgressIndicator(value: progress),
            ),
            const SizedBox(height: 20),
            if (startTime != null)
              Text("Start: ${startTime!.toLocal()}"),
            if (endTime != null && !isRunning)
              Text("End: ${endTime!.toLocal()}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? null : startProcess,
              child: const Text("Start Process"),
            )
          ],
        ),
      ),
    );
  }
}
