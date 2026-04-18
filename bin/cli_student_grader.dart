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

// 4. Record Score — Option 2
void recordScore(List<Map<String, dynamic>> students, Set<String> subjects) {
  if (students.isEmpty) {
    print("No students available!");
    return;
  }

  // Show students using indexed for loop
  print("Select a student:");
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Enter number: ");
  int index = int.tryParse((stdin.readLineSync() ?? "").trim()) ?? -1;
  if (index < 1 || index > students.length) {
    print("Invalid selection!");
    return;
  }

  var student = students[index - 1];

  // Show subjects
  print("Available subjects:");
  for (var subject in subjects) {
    print("  - $subject");
  }

  // Score validation using while loop
  int score;
  while (true) {
    stdout.write("Enter score (0-100): ");
    score = int.tryParse((stdin.readLineSync() ?? "").trim()) ?? -1;

    if (score >= 0 && score <= 100) {
      break;
    } else {
      print("Invalid score. Try again.");
    }
  }

  (student["scores"] as List<int>).add(score);
  print("Score $score added to ${student["name"]} successfully!");
}

// 5. Add Bonus Points — Option 3
void addBonus(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available!");
    return;
  }

  print("Select a student:");
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Enter number: ");
  int index = int.tryParse((stdin.readLineSync() ?? "").trim()) ?? -1;
  if (index < 1 || index > students.length) {
    print("Invalid selection!");
    return;
  }

  var student = students[index - 1];

  stdout.write("Enter bonus points (1–10): ");
  int bonusValue = int.tryParse((stdin.readLineSync() ?? "").trim()) ?? 0;

  if (bonusValue < 1 || bonusValue > 10) {
    print("Invalid bonus value!");
    return;
  }

  if (student["bonus"] == null) {
    student["bonus"] = bonusValue;
    print("Bonus of $bonusValue added to ${student["name"]} successfully!");
  } else {
    print("Bonus already exists for ${student["name"]}!");
  }
}
