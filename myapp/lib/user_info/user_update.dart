import 'package:flutter/material.dart';
import 'package:myapp/views/homepage.dart';

class UserUpdate extends StatelessWidget {
  const UserUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enter Herd ID',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'SF-Pro', // Assuming you have this font
      ),
      home: const EnterHerdIdScreen(),
    );
  }
}

class EnterHerdIdScreen extends StatefulWidget {
  const EnterHerdIdScreen({super.key});

  @override
  State<EnterHerdIdScreen> createState() => _EnterHerdIdScreenState();
}

class _EnterHerdIdScreenState extends State<EnterHerdIdScreen> {
  final TextEditingController _herdIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(
        249,
        172,
        207,
        1,
      ), // Light pink background
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 172, 207, 1),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomepage()),
              );
            },
          ),
        ),
      ),
      body: Stack(
        // Use Stack to position the pig
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 180,
                  ), // Add spacing to push content down
                  // "Enter HERD ID" Text
                  const Text(
                    'Enter HERD ID',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Text Field for Herd ID
                  TextField(
                    controller: _herdIdController,
                    decoration: InputDecoration(
                      hintText: 'Enter HERD ID',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle confirm button action
                        String herdId = _herdIdController.text;
                        print('Entered Herd ID: $herdId');
                        // You can navigate to the next screen or perform validation here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Pig Image positioned at the top right
          Positioned(
            top: 0,
            right: -16,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                width: 300.0, // Adjust width
                height: 300.0, // Adjust height
                child: Image.asset(
                  'assets/images/Icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
