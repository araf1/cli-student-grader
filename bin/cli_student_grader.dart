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

      case 2:
        recordScore(students, availableSubjects);
        break;

      case 3:
        addBonus(students);
        break;

      case 4:
        addComment(students);
        break;

      case 5:
        viewAllStudents(students);
        break;

      case 6:
        viewReportCard(students);
        break;

      case 7:
        classSummary(students);
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

  stdout.write("Enter Score: ");
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

  stdout.write("Bonus number: ");
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

// 6. Add Comment — Option 4
void addComment(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available!");
    return;
  }

  print("Select a student:");
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Comment: ");
  int index = int.tryParse((stdin.readLineSync() ?? "").trim()) ?? -1;
  if (index < 1 || index > students.length) {
    print("Invalid selection!");
    return;
  }

  var student = students[index - 1];

  stdout.write("Enter comment: ");
  String? comment = stdin.readLineSync();

  student["comment"] = comment?.trim();
  print("Comment added to ${student["name"]} successfully!");
}

// 7. View All Students — Option 5
void viewAllStudents(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available!");
    return;
  }

  print("\n=== All Students ===");

  for (var student in students) {
    var tags = [
      student["name"],
      "${(student["scores"] as List).length} scores",
      if (student["bonus"] != null) "⭐ Has Bonus",
    ];

    print(tags.join(" | "));
  }
}

// 8. View Report Card — Option 6
void viewReportCard(List<Map<String, dynamic>> students) {
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
  List<int> scores = List<int>.from(student["scores"]);

  if (scores.isEmpty) {
    print("No scores recorded for ${student["name"]}!");
    return;
  }

  // Calculate sum
  int sum = 0;
  for (int i = 0; i < scores.length; i++) {
    sum += scores[i];
  }

  double rawAvg = sum / scores.length;

  // Add bonus using ??
  int bonus = student["bonus"] ?? 0;
  double finalAvg = rawAvg + bonus;

  // Cap at 100
  if (finalAvg > 100) finalAvg = 100;

  // Grade calculation
  String grade;
  if (finalAvg >= 90) {
    grade = "A";
  } else if (finalAvg >= 80) {
    grade = "B";
  } else if (finalAvg >= 70) {
    grade = "C";
  } else if (finalAvg >= 60) {
    grade = "D";
  } else {
    grade = "F";
  }

  // Comment with ?. and ??
  String comment = student["comment"]?.toUpperCase() ?? "No comment provided";

  // Feedback using switch expression
  String feedback = switch (grade) {
    "A" => "Outstanding performance!",
    "B" => "Good work, keep it up!",
    "C" => "Satisfactory. Room to improve.",
    "D" => "Needs improvement.",
    "F" => "Failing. Please seek help.",
    _ => "Unknown grade.",
  };

  print("""
╔══════════════════════════════╗
║         REPORT CARD          ║
╠══════════════════════════════╣
║  Name:     ${student["name"]}
║  Scores:   $scores
║  Bonus:    +$bonus
║  Average:  ${finalAvg.toStringAsFixed(1)}
║  Grade:    $grade
║  Comment:  $comment
║  Feedback: $feedback
╚══════════════════════════════╝""");
}

// 9. Class Summary — Option 7
void classSummary(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available!");
    return;
  }

  int totalStudents = students.length;
  double totalAvg = 0;
  double highest = 0;
  double lowest = 100;
  int counted = 0;
  int passCount = 0;

  Set<String> uniqueGrades = {};

  // Helper to calculate average
  double calculateAvg(Map<String, dynamic> student) {
    List<int> scores = List<int>.from(student["scores"]);
    if (scores.isEmpty) return 0;

    int sum = 0;
    for (var s in scores) {
      sum += s;
    }

    double avg = sum / scores.length;
    avg += (student["bonus"] ?? 0);
    if (avg > 100) avg = 100;
    return avg;
  }

  for (var student in students) {
    double avg = calculateAvg(student);

    if ((student["scores"] as List).isNotEmpty) {
      totalAvg += avg;
      counted++;

      if (avg >= 60) passCount++;

      if (avg > highest) highest = avg;
      if (avg < lowest) lowest = avg;

      String grade;
      if (avg >= 90) {
        grade = "A";
      } else if (avg >= 80) {
        grade = "B";
      } else if (avg >= 70) {
        grade = "C";
      } else if (avg >= 60) {
        grade = "D";
      } else {
        grade = "F";
      }

      uniqueGrades.add(grade);
    }
  }

  double classAvg = counted > 0 ? totalAvg / counted : 0;

  // Collection for
  var summaryLines = [
    for (var s in students)
      "  ${s["name"]}: ${calculateAvg(s).toStringAsFixed(1)}",
  ];

  print("\n=== Class Summary ===");
  print("Total Students  : $totalStudents");
  print("Class Average   : ${classAvg.toStringAsFixed(1)}");
  print("Highest Average : ${highest.toStringAsFixed(1)}");
  print("Lowest Average  : ${lowest.toStringAsFixed(1)}");
  print("Passing Students: $passCount / $counted");
  print("\nStudent Averages:");
  for (var line in summaryLines) {
    print(line);
  }
  print("\nUnique Grades: $uniqueGrades");
}
