
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Management App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

// ---------------- LOGIN PAGE ----------------

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController =
      TextEditingController();

  TextEditingController passwordController =
      TextEditingController();

  // YOUR EMAIL ID AND PASSWORD

  final String validEmail = "gopikajaisankar547@gmail.com";
  final String validPassword = "gopika1109";

  String errorMessage = "";

  // LOGIN FUNCTION

  void login() {

    String enteredEmail =
        emailController.text.trim();

    String enteredPassword =
        passwordController.text.trim();

    // IMPORTANT IF ELSE CONDITION

    if (enteredEmail == validEmail &&
        enteredPassword == validPassword) {

      // Correct Email and Password

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );

    } else {

      // Wrong Email or Password

      setState(() {
        errorMessage =
            "Invalid Email ID or Password";
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue.shade50,

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(
                Icons.lock,
                size: 80,
                color: Colors.blue,
              ),

              SizedBox(height: 20),

              Text(
                "LOGIN PAGE",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              // EMAIL FIELD

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  labelText: "Enter Email ID",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              SizedBox(height: 20),

              // PASSWORD FIELD

              TextField(
                controller: passwordController,
                obscureText: true,

                decoration: InputDecoration(
                  labelText: "Enter Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              SizedBox(height: 15),

              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: login,
                child: Text("LOGIN"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- TASK MODEL ----------------

class Task {

  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

// ---------------- HOME PAGE ----------------

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userName = "My Name";

  List<Task> tasks = [

    Task("Complete Assignment", true),
    Task("Study Dart", false),
    Task("Learn Flutter", true),
    Task("Prepare Notes", false),
    Task("Complete Project", true),

  ];

  // TOTAL TASKS

  int get total => tasks.length;

  // COMPLETED TASKS

  int get completed =>
      tasks.where((task) => task.isCompleted).length;

  // PENDING TASKS

  int get pending => total - completed;

  // UPDATE TASK STATUS

  void updateTask(int index) {

    setState(() {

      if (tasks[index].isCompleted == true) {

        tasks[index].isCompleted = false;

      } else {

        tasks[index].isCompleted = true;

      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Home Page"),

        actions: [

          // PROFILE BUTTON

          IconButton(
            icon: Icon(Icons.person),

            onPressed: () async {

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userName: userName,
                  ),
                ),
              );

              if (result != null) {

                setState(() {
                  userName = result;
                });

              }

            },
          ),

          // LOGOUT BUTTON

          IconButton(
            icon: Icon(Icons.logout),

            onPressed: () {

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );

            },
          ),

        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Welcome $userName",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            // TOTAL COMPLETED PENDING

            Row(
              children: [

                Expanded(
                  child: buildCard(
                    "Total",
                    total,
                    Colors.blue,
                  ),
                ),

                Expanded(
                  child: buildCard(
                    "Completed",
                    completed,
                    Colors.green,
                  ),
                ),

                Expanded(
                  child: buildCard(
                    "Pending",
                    pending,
                    Colors.orange,
                  ),
                ),

              ],
            ),

            SizedBox(height: 25),

            Text(
              "My Tasks",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            // TASK LIST

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,

                itemBuilder: (context, index) {

                  return Card(

                    child: ListTile(

                      title: Text(tasks[index].title),

                      subtitle: Text(
                        tasks[index].isCompleted
                            ? "Completed"
                            : "Not Completed",
                      ),

                      leading: Icon(
                        tasks[index].isCompleted
                            ? Icons.check_circle
                            : Icons.pending,
                        color: tasks[index].isCompleted
                            ? Colors.green
                            : Colors.orange,
                      ),

                      trailing: Checkbox(
                        value: tasks[index].isCompleted,

                        onChanged: (value) {
                          updateTask(index);
                        },
                      ),

                    ),
                  );

                },
              ),
            ),

            // COMPLETED AND PENDING BUTTONS

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(
                            tasks: tasks,
                            showCompleted: true,
                          ),
                        ),
                      );

                    },
                    child: Text("Completed Tasks"),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(
                            tasks: tasks,
                            showCompleted: false,
                          ),
                        ),
                      );

                    },
                    child: Text("Pending Tasks"),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  // DASHBOARD CARD

  Widget buildCard(
      String title, int count, Color color) {

    return Card(
      color: color,

      child: Padding(
        padding: EdgeInsets.all(12),

        child: Column(
          children: [

            Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "$count",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

// ---------------- TASK PAGE ----------------

class TaskPage extends StatelessWidget {

  final List<Task> tasks;
  final bool showCompleted;

  TaskPage({
    required this.tasks,
    required this.showCompleted,
  });

  @override
  Widget build(BuildContext context) {

    List<Task> filteredTasks;

    // IF ELSE CONDITION

    if (showCompleted == true) {

      filteredTasks = tasks
          .where((task) => task.isCompleted == true)
          .toList();

    } else {

      filteredTasks = tasks
          .where((task) => task.isCompleted == false)
          .toList();

    }

    return Scaffold(

      appBar: AppBar(
        title: Text(
          showCompleted
              ? "Completed Tasks"
              : "Not Completed Tasks",
        ),
      ),

      body: filteredTasks.isEmpty

          ? Center(
              child: Text("No Tasks Available"),
            )

          : ListView.builder(

              itemCount: filteredTasks.length,

              itemBuilder: (context, index) {

                return Card(
                  child: ListTile(

                    leading: Icon(
                      showCompleted
                          ? Icons.check_circle
                          : Icons.pending,
                      color: showCompleted
                          ? Colors.green
                          : Colors.orange,
                    ),

                    title: Text(
                      filteredTasks[index].title,
                    ),

                    subtitle: Text(
                      showCompleted
                          ? "Completed"
                          : "Not Completed",
                    ),

                  ),
                );

              },
            ),
    );
  }
}

// ---------------- PROFILE PAGE ----------------

class ProfilePage extends StatefulWidget {

  final String userName;

  ProfilePage({
    required this.userName,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.userName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // SAVE NAME FUNCTION

  void onSaveName() {

    String name = nameController.text.trim();

    // IF ELSE CONDITION

    if (name.isNotEmpty) {

      Navigator.pop(context, name);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Enter Your Name"),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Profile Page"),
      ),

      body: Padding(
        padding: EdgeInsets.all(25),

        child: Column(
          children: [

            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue.shade100,

              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.blue,
              ),
            ),

            SizedBox(height: 25),

            Text(
              "MY PROFILE",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            TextField(
              controller: nameController,

              decoration: InputDecoration(
                labelText: "Edit Your Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: onSaveName,

              icon: Icon(Icons.save),

              label: Text("SAVE NAME"),
            ),

          ],
        ),
      ),
    );
  }
}
