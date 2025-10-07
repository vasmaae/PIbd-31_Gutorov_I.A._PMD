enum Priority { low, medium, high }

enum Status { todo, inProgress, done }

class Task {
  final String title;
  final String? description;
  final DateTime? deadline;
  final Priority priority;
  final Status status;

  Task({
    required this.title,
    this.description,
    this.deadline,
    required this.priority,
    required this.status,
  });
}

extension TaskExtension on Task {
  String get formattedInfo {
    final deadlineInfo = deadline != null
        ? ' до ${deadline!.toString().split(' ')[0]}'
        : '';
    return '$title (${priority.name})${deadlineInfo} - ${status.name}';
  }

  bool get isOverdue {
    if (deadline == null) return false;
    return deadline!.isBefore(DateTime.now());
  }
}

class TaskCollection<T extends Task> {
  final List<T> _items;

  TaskCollection(this._items);

  Future<List<T>> filterTasks(bool Function(T) predicate) async {
    await Future.delayed(Duration(milliseconds: 100));
    return _items.where(predicate).toList();
  }

  List<R> mapTasks<R>(R Function(T) transform) {
    final result = <R>[];
    for (var item in _items) {
      result.add(transform(item));
    }
    return result;
  }
}

class ToDoList {
  final List<Task> _tasks;

  ToDoList(this._tasks);

  Future<List<Task>> getTasks({Priority? priority, Status? status}) async {
    List<Task> filteredTasks = <Task>[];
    for (var task in _tasks) {
      if (priority != null && task.priority != priority) continue;
      if (status != null && task.status != status) continue;
      filteredTasks.add(task);
    }
    return filteredTasks;
  }

  Future<void> addTask(Task task) async {
    await Future.delayed(Duration(milliseconds: 50));
    _tasks.add(task);
  }

  Future<void> printTasks() async {
    _tasks.forEach((task) => print("${task.title} ${task.deadline}"));
  }

  Future<void> processHighPriorityTasks() async {
    final highPriorityTasks = await getTasks(priority: Priority.high);

    highPriorityTasks.forEach((task) {
      final processTask = (Task t) {
        print('Обрабатывается высокоприоритетная задача: ${t.title}');
        if (t.isOverdue) {
          print('⚠️ Просрочена: ${t.title}');
        }
      };

      processTask(task);
    });
  }
}

void main() async {
  final tasks = [
    Task(
      title: 'Изучить Dart',
      description: 'Изучить основы языка Dart',
      deadline: DateTime(2024, 12, 31),
      priority: Priority.high,
      status: Status.inProgress,
    ),
    Task(
      title: 'Купить продукты',
      description: 'Молоко, хлеб, яйца',
      deadline: DateTime(2024, 1, 15),
      priority: Priority.medium,
      status: Status.todo,
    ),
    Task(title: 'Прочитать книгу', priority: Priority.low, status: Status.done),
  ];

  final taskCollection = TaskCollection<Task>(tasks);
  final toDoList = ToDoList(tasks);

  final urgentTasks = await taskCollection.filterTasks((task) {
    return task.priority == Priority.high || task.isOverdue;
  });

  print('Срочные задачи:');
  urgentTasks.forEach((task) => print(task.formattedInfo));

  print('\nВсе задачи с расширенной информацией:');
  for (var task in tasks) {
    print(task.formattedInfo);
    if (task.isOverdue) {
      print('   ⚠️ ЭТА ЗАДАЧА ПРОСРОЧЕНА!');
    }
  }

  final taskTitles = taskCollection.mapTasks<String>((task) => task.title);
  print('\nНазвания всех задач: $taskTitles');

  print('\nОбработка высокоприоритетных задач:');
  await toDoList.processHighPriorityTasks();

  final newTask = Task(
    title: 'Написать тесты',
    priority: Priority.medium,
    status: Status.todo,
  );

  await toDoList.addTask(newTask);
  print('\nПосле добавления новой задачи:');
  await toDoList.printTasks();
}
