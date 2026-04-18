import 'dart:io';

void main() {
  // 1. App Setup & Constants
  const String appTitle = "Student Grader v1.0";

  // Available subjects (final because it won't change)
  final Set<String> availableSubjects = {"Math", "English", "Science", "ICT"};

  // Mutable state (var)
  var students = <Map<String, dynamic>>[];
  var isRunning = true;

  // 2. Menu Loop (do-while + switch)
  do {
    print("===== $appTitle =====");
    print("");
    print("1. Add Student");
    print("2. Record Score");
    print("3. Add Bonus Points");
    print("4. Add Comment");
    print("5. View All Students");
    print("6. View Report Card");
    print("7. Class Summary");
    print("8. Exit");
    print("");
    stdout.write("Choose an option: ");

    String? input = stdin.readLineSync();
    int choice = int.tryParse((input ?? "").trim()) ?? 0;

    switch (choice) {
      case 1:
        addStudent(students, availableSubjects);
        break;

      case 8:
        print("Exiting program...");
        isRunning = false;
        break;

      default:
        print("Invalid option. Try again.");
    }

    if (isRunning) {
      print(""); // spacing between actions
    }
  } while (isRunning);
}

// 3. Add Student — Option 1
void addStudent(List<Map<String, dynamic>> students, Set<String> subjects) {
  stdout.write("Enter student name: ");
  String? name = stdin.readLineSync();

  if (name == null || name.trim().isEmpty) {
    print("Invalid name!");
    return;
  }

  name = name.trim();

  // Creating student map
  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...subjects},
    "bonus": null,
    "comment": null,
  };

  students.add(student);
  print("Student '$name' added successfully!");
}
