import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/user_info/application_form.dart';
import 'package:myapp/user_info/user_list.dart';
import 'package:myapp/user_info/user_profile.dart';
import 'package:myapp/user_info/user_update.dart';
import 'package:myapp/views/loginpage.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 5,
        titleSpacing: 0.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search Municipality or Owner',
              suffixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            ),
          ),
        ),
        actions: const [SizedBox(width: 10.0)],
      ),
      drawer: const MainDrawer(),
      body: Stack(
        children: <Widget>[
          Image.asset('assets/images/Map.png'),
          Container(
            color: Colors.black.withOpacity(0.1),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(15.0),
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 50.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      'RECENT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const RecentItem(
                        name: 'Vaughn Ashton',
                        number: '#1011',
                        location: 'NAGA CITY'),
                    const RecentItem(
                        name: 'Marjun Mapa',
                        number: '#5899',
                        location: 'NAGA CITY'),
                    const RecentItem(
                        name: 'Prince Albert',
                        number: '#9274',
                        location: 'NAGA CITY'),
                    const RecentItem(
                        name: 'Bensky Abdon',
                        number: '#8546',
                        location: 'NAGA CITY'),
                    const RecentItem(
                        name: 'Karie Nina',
                        number: '#3976',
                        location: 'NAGA CITY'),
                    const RecentItem(
                        name: 'Clyde Arizala',
                        number: '#7314',
                        location: 'NAGA CITY'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RecentItem extends StatelessWidget {
  const RecentItem({
    super.key,
    required this.name,
    required this.number,
    required this.location,
  });

  final String name;
  final String number;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.pink,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '$number - $location',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

    Future<void> _logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to LoginScreen after successful sign out.
      // Important: Use pushReplacement to avoid the user being able to
      // go back to the logged-in screen with the back button.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      // Handle errors, e.g., display a message to the user
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to sign out. Please check your connection."),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40.0,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'MAPA Tech',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ADMIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Register Owner'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApplicationForm()),
              ); // Add navigation logic for Register Owner here
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('List of Owners'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserList()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.upload),
            title: const Text('Update'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserUpdate()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
            _logOut(context);
            },
          ),
        ],
      ),
    );
  }
}