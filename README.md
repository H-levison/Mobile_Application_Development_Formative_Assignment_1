# 🎓 ALU Student Academic Assistant

> **A comprehensive mobile solution for managing academic life at African Leadership University.**

## 📋 Project Overview
The **ALU Student Academic Assistant** is a Flutter-based mobile application designed to help students balance their academic responsibilities with university life. Addressing common challenges like missed deadlines and attendance tracking, this app serves as a personal academic manager.

**Key Problem Solved:** Students struggle to track assignments, remember class schedules, and monitor their attendance, leading to unnecessary stress and academic penalties.
**Our Solution:** A unified platform to organize coursework, visualize schedules, and automatically track attendance metrics against the ALU 75% requirement.

---

## ✨ Key Features

### 1. 📊 Smart Dashboard
- **Real-time Overview:** View today’s date, active week, and immediate schedule.
- **Attendance Monitor:** Visual progress bar tracking overall attendance percentage.
- **Warning System:** **Red alert** indicator when attendance drops below 75%.
- **Assignment Summary:** Quick count of pending assignments due within 7 days.

### 2. 📝 Assignment Management
- **CRUD Functionality:** Create, Read, Update, and Delete assignments.
- **Prioritization:** Tag tasks as *High*, *Medium*, or *Low* priority.
- **Smart Sorting:** Assignments are automatically sorted by due date.
- **Completion Tracking:** Check off tasks as you finish them.

### 3. 📅 Academic Schedule & Attendance
- **Session Planning:** Schedule Classes, Mastery Sessions, Study Groups, or PSL Meetings.
- **Attendance Toggles:** Mark yourself as "Present" or "Absent" for each session.
- **Automatic Calculations:** The app dynamically recalculates your attendance percentage based on your inputs.

### 4. 💾 Data Persistence (Extra Effort)
- **Local Storage:** Utilizes `shared_preferences` to save all user data locally on the device.
- **State Preservation:** Assignments and schedules remain saved even after closing and restarting the app.

---

## 🛠️ Tech Stack & Architecture

This project follows a **Modular Architecture** to separate UI, Logic, and Data, ensuring code quality and maintainability.

* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **State Management:** `setState` (Lifted State Access)
* **Local Storage:** `shared_preferences`
* **Utilities:** `intl` (Date Formatting), `uuid` (Unique IDs)

### 📂 Folder Structure
The codebase is organized for scalability:

```text
lib/
├── models/         # Data structures (Assignment, AcademicSession)
├── screens/        # UI Pages (Dashboard, Assignments, Schedule)
├── services/       # Business Logic (DataService for storage)
├── theme/          # Design System (ALUColors, ThemeData)
├── widgets/        # Reusable UI Components
└── main.dart       # App Entry Point & Navigation Logic


```
🚀 Installation & Setup
Follow these steps to run the project locally on your machine.

1. Prerequisites
Ensure you have the following installed:

Flutter SDK: Install Guide

VS Code or Android Studio

Git: Download Git

An Android Emulator or physical device connected via USB.

2. Clone the Repository
Open your terminal and run the following commands:

# Clone the project
git clone [https://github.com/YourUsername/alu_academic_assistant.git](https://github.com/YourUsername/alu_academic_assistant.git)

# Navigate into the project directory
cd alu_academic_assistant

3. Install Dependencies
Download the required packages (shared_preferences, intl, uuid) listed in pubspec.yaml:

Bash
flutter pub get

4. Run the Application
Connect your device or start your emulator, then run:

Bash
flutter run

📱 User Guide
Dashboard: Check the "At a Glance" section for your daily summary. The attendance card will turn Red if you are below 75%.

Assignments: Tap the + button to add a new task. Swipe an item left to Delete it. Tap the checkbox to mark it Done.

Schedule: Add your classes for the week. Use the "Present/Absent" chips on each card to log your attendance.

👥 Contributors
HonourGod Levison - Project Lead & Navigation

Dan Nkusi - UI/UX Design & Dashboard Logic

Erica Ishimwe - Assignment Management Feature

Kadi Koita - Schedule & Attendance Tracking

Loic Higiro - Data Persistence & Storage

📄 License
This project is created for the Mobile App Development course at African Leadership University.
