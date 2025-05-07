import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/views/homepage.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Owner & Herds Info',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        hintColor: Colors.grey,
        fontFamily: 'SF-Pro',
      ),
      home: OwnerHerdsInfoScreen(),
      routes: {
        '/edit_profile':
            (context) => EditProfileScreen(
              initialData:
                  ModalRoute.of(context)?.settings.arguments
                      as Map<String, dynamic>? ??
                  {
                    'firstName': 'VAUGHN', //separate first name
                    'middleName': 'ASHTON LOUIS',
                    'lastName': 'Pramis',
                    'birthdate': 'NOVEMBER - 10 - 2004',
                    'gender': 'MALE',
                    'contact': '+63 071377643',
                    'location': 'XAVIER HALL, NAGA CITY',
                    'population': 7,
                    'herd': 2,
                    'herdId': '#1011-1',
                    'updated': DateFormat(
                      'MMMM - dd -mapstruct',
                    ).format(DateTime.now()),
                    'next': DateFormat(
                      'MMMM - dd -mapstruct',
                    ).format(DateTime.now().add(Duration(days: 15))),
                  },
              onProfileUpdated: (updatedData) {
                //  This callback is called when data is saved in EditProfileScreen.
                //  We'll update the state in OwnerHerdsInfoScreen from here.
              },
            ),
      },
    );
  }
}

class OwnerHerdsInfoScreen extends StatefulWidget {
  const OwnerHerdsInfoScreen({super.key});

  @override
  _OwnerHerdsInfoScreenState createState() => _OwnerHerdsInfoScreenState();
}

class _OwnerHerdsInfoScreenState extends State<OwnerHerdsInfoScreen> {
  String _firstName = 'VAUGHN'; // separate first name
  String _middleName = 'ASHTON LOUIS';
  String _lastName = 'PRAMIS';
  String _birthdate = 'NOVEMBER - 10 - 2004';
  String _gender = 'MALE';
  String _contact = '+63 071377643';
  String _location = 'XAVIER HALL, NAGA CITY';
  int _population = 7;
  int _herd = 2;
  String _herdId = '#1011-1';
  String _updated = DateFormat('MMMM - dd -mapstruct').format(DateTime.now());
  String _next = DateFormat(
    'MMMM - dd -mapstruct',
  ).format(DateTime.now().add(Duration(days: 15)));

  void _navigateToEditProfile() async {
    final result = await Navigator.pushNamed(
      context,
      '/edit_profile',
      arguments: {
        'firstName': _firstName, // pass first name
        'middleName': _middleName,
        'lastName': _lastName,
        'birthdate': _birthdate,
        'gender': _gender,
        'contact': _contact,
        'location': _location,
        'population': _population,
        'herd': _herd,
        'herdId': _herdId,
        'updated': _updated,
        'next': _next,
      },
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        // Update the name and herd ID
        _firstName = result['firstName'] ?? _firstName; //update first name
        _middleName = result['middleName'] ?? _middleName;
        _lastName = result['lastName'] ?? _lastName;
        _herdId = result['herdId'] ?? _herdId;
        _birthdate = result['birthdate'] ?? _birthdate;
        _gender = result['gender'] ?? _gender;
        _contact = result['contact'] ?? _contact;
        _location = result['location'] ?? _location;
        _population = result['population'] ?? _population;
        _herd = result['herd'] ?? _herd;

        _updated = result['updated'] ?? _updated;
        _next = result['next'] ?? _next;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomepage()),
            );
            // Handle back button action
          },
        ),
        title: Text('OWNER & HERDS INFO'),
        actions: [
          IconButton(icon: Icon(Icons.edit), onPressed: _navigateToEditProfile),
        ],
        backgroundColor: Colors.pink[100],
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'URL_TO_OWNER_IMAGE',
                    ), // Replace with actual image URL
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                '${_firstName} ${_herdId}', // Display first name and herd ID
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(color: Colors.grey[300], thickness: 1.0, height: 30.0),
            _buildInfoRow(
              Icons.person_outline,
              '$_lastName, ${_firstName} ${_middleName}',
            ), // display full name
            _buildInfoRow(Icons.calendar_today_outlined, _birthdate),
            _buildInfoRow(Icons.man_outlined, _gender),
            _buildInfoRow(Icons.phone_outlined, _contact),
            _buildInfoRow(Icons.location_on_outlined, _location),
            SizedBox(height: 16.0),
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(child: Text('MAP PREVIEW')),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                'COORDINATES',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 24.0),
            Center(
              child: Text(
                'STATUS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Image.network('URL_TO_HERDS_IMAGE', fit: BoxFit.cover),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusIndicator(Colors.green),
                _buildStatusIndicator(Colors.yellow),
                _buildStatusIndicator(Colors.red),
                _buildStatusIndicator(Colors.white, border: true),
                _buildStatusIndicator(Colors.grey),
              ],
            ),
            SizedBox(height: 24.0),
            Text(
              'CURRENT STATUS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            _buildInfoRow(Icons.groups_outlined, 'POPULATION - $_population'),
            _buildInfoRow(Icons.layers_outlined, 'HERD - $_herd'),
            _buildInfoRow(Icons.badge_outlined, 'HERD ID - $_herdId'),
            _buildInfoRow(Icons.calendar_today_outlined, 'UPDATED - $_updated'),
            _buildInfoRow(Icons.event_available_outlined, 'NEXT - $_next'),
            SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle update button action
                },
                child: Text('UPDATE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.grey[600]),
          SizedBox(width: 16.0),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(Color color, {bool border = false}) {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: border ? Border.all(color: Colors.black12) : null,
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onProfileUpdated;

  EditProfileScreen({
    required this.initialData,
    required this.onProfileUpdated,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthdateController;
  late TextEditingController _genderController;
  late TextEditingController _contactController;
  late TextEditingController _locationController;
  late TextEditingController _populationController;
  late TextEditingController _herdController;
  late TextEditingController _herdIdController;
  late TextEditingController _updatedController;
  late TextEditingController _nextController;

  final DateFormat _dateFormat = DateFormat('MMMM - dd -mapstruct');

  @override
  void initState() {
    super.initState();
    //  Initialize the name without the herd ID.
    _firstNameController = TextEditingController(
      text: widget.initialData['firstName'] ?? '',
    );
    _middleNameController = TextEditingController(
      text: widget.initialData['middleName'] ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.initialData['lastName'] ?? '',
    );
    _birthdateController = TextEditingController(
      text: widget.initialData['birthdate'] ?? '',
    );
    _genderController = TextEditingController(
      text: widget.initialData['gender'] ?? '',
    );
    _contactController = TextEditingController(
      text: widget.initialData['contact'] ?? '',
    );
    _locationController = TextEditingController(
      text: widget.initialData['location'] ?? '',
    );
    _populationController = TextEditingController(
      text: widget.initialData['population']?.toString() ?? '',
    );
    _herdController = TextEditingController(
      text: widget.initialData['herd']?.toString() ?? '',
    );
    _herdIdController = TextEditingController(
      text: widget.initialData['herdId'] ?? '',
    );
    _updatedController = TextEditingController(
      text: widget.initialData['updated'] ?? '',
    );
    _nextController = TextEditingController(
      text: widget.initialData['next'] ?? '',
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _birthdateController.dispose();
    _genderController.dispose();
    _contactController.dispose();
    _locationController.dispose();
    _populationController.dispose();
    _herdController.dispose();
    _herdIdController.dispose();
    _updatedController.dispose();
    _nextController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final newFirstName =
        _firstNameController.text.trim(); //  Do not add  "#1011" here.
    final newMiddleName = _middleNameController.text.trim();
    final newLastName = _lastNameController.text.trim();
    final newBirthdate = _birthdateController.text.trim();
    final newGender = _genderController.text.trim();
    final newContact = _contactController.text.trim();
    final newLocation = _locationController.text.trim();
    final newPopulation = int.tryParse(_populationController.text.trim()) ?? 0;
    final newHerd = int.tryParse(_herdController.text.trim()) ?? 0;
    final newHerdId = _herdIdController.text.trim();
    final newUpdated = _updatedController.text.trim();
    final newNext = _nextController.text.trim();

    if (newFirstName.isNotEmpty &&
        newMiddleName.isNotEmpty &&
        newLastName.isNotEmpty &&
        newBirthdate.isNotEmpty &&
        newGender.isNotEmpty &&
        newContact.isNotEmpty &&
        newLocation.isNotEmpty &&
        newPopulation >= 0 &&
        newHerd >= 0 &&
        newHerdId.isNotEmpty &&
        newUpdated.isNotEmpty &&
        newNext.isNotEmpty) {
      Navigator.pop(context, {
        'firstName': newFirstName, // Pass the first name
        'middleName': newMiddleName,
        'lastName': newLastName,
        'birthdate': newBirthdate,
        'gender': newGender,
        'contact': newContact,
        'location': newLocation,
        'population': newPopulation,
        'herd': newHerd,
        'herdId': newHerdId, // Include herdId in the data passed back
        'updated': newUpdated,
        'next': newNext,
      });
      widget.onProfileUpdated({
        //  Pass the  name and herdId back
        'firstName': newFirstName,
        'middleName': newMiddleName,
        'lastName': newLastName,
        'birthdate': newBirthdate,
        'gender': newGender,
        'contact': newContact,
        'location': newLocation,
        'population': newPopulation,
        'herd': newHerd,
        'herdId': newHerdId,
        'updated': newUpdated,
        'next': newNext,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all the fields with valid data.'),
        ),
      );
    }
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final formattedDate = _dateFormat.format(pickedDate);
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _middleNameController,
              decoration: InputDecoration(
                labelText: 'Middle Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _birthdateController,
              decoration: InputDecoration(
                labelText: 'Birthdate',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _birthdateController),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contactController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _populationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Population',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _herdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Herd',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _herdIdController,
              decoration: InputDecoration(
                labelText: 'Herd ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _updatedController,
              decoration: InputDecoration(
                labelText: 'Updated Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _updatedController),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nextController,
              decoration: InputDecoration(
                labelText: 'Next Update Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _nextController),
            ),
          ],
        ),
      ),
    );
  }
}
