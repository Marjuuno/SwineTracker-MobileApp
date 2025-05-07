import 'package:flutter/material.dart';
import 'package:myapp/views/homepage.dart';
import 'application_form.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List of Owners',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color.fromRGBO(249, 172, 207, 1),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: OwnerListScreen(),
    );
  }
}

class Owner {
  final String nameId;
  final String location;
  final int population;
  final int herds;
  final int drove;
  final String status;
  final String imagePath;

  Owner({
    required this.nameId,
    required this.location,
    required this.population,
    this.herds = 0,
    this.drove = 0,
    required this.status,
    required this.imagePath,
  });
}

class OwnerListScreen extends StatelessWidget {
  final List<Owner> owners = [
    Owner(
      nameId: 'Vaun Ashton #1011',
      location: 'Naga City, Xavier Hall',
      population: 7,
      herds: 2,
      status: 'Safe',
      imagePath: 'assets/images/profile_picture/vaughn.jpg', // Placeholder
    ),
    Owner(
      nameId: 'Marjun Mapa #2135',
      location: 'Naga City Dayangdang',
      population: 5,
      drove: 1,
      status: 'Surveillance',
      imagePath:
          'https://via.placeholder.com/100/ADD8E6/000000?Text=Marjun', // Placeholder
    ),
    Owner(
      nameId: 'Prince Albert #9274',
      location: 'Naga City Pacol',
      population: 7,
      drove: 1,
      status: 'Infected',
      imagePath: 'assets/images/profile_picture/ping.jpg', // Placeholder
    ),
    Owner(
      nameId: 'Bensky Abdon #8546',
      location: 'Naga City San Felipe',
      population: 0,
      drove: 0,
      status: 'N/A',
      imagePath: 'assets/images/profile_picture/Bensky.jpg', // Placeholder
    ),
    Owner(
      nameId: 'Karie Nina #3976',
      location: 'Naga City Tabuco',
      population: 0,
      drove: 0,
      status: 'N/A',
      imagePath:
          'https://via.placeholder.com/100/FFA07A/000000?Text=Karie', // Placeholder
    ),
    Owner(
      nameId: 'Clyde Arizala #7314',
      location: 'Naga City Penafrancia',
      population: 21,
      drove: 3,
      status: 'Safe',
      imagePath:
          'https://via.placeholder.com/100/AFEEEE/000000?Text=Clyde', // Placeholder
    ),
  ];

  OwnerListScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'safe':
        return Colors.green;
      case 'surveillance':
        return Colors.orange;
      case 'infected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIST OF OWNERS', style: TextStyle(fontFamily: 'SF-Pro')),
        backgroundColor: const Color.fromRGBO(249, 172, 207, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomepage()),
              );
            },
          ),
        ),
        titleSpacing: 5,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApplicationForm(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: owners.length,
        itemBuilder: (context, index) {
          final owner = owners[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                    owner.imagePath.startsWith('http')
                        ? NetworkImage(owner.imagePath)
                        : AssetImage(owner.imagePath) as ImageProvider,
              ),
              title: Text(
                owner.nameId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF-Pro',
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(owner.location, style: TextStyle(fontFamily: 'SF-Pro')),
                  Text(
                    'Population: ${owner.population}',
                    style: TextStyle(fontFamily: 'SF-Pro'),
                  ),
                  if (owner.herds != 0)
                    Text(
                      'Herds: ${owner.herds}',
                      style: TextStyle(fontFamily: 'SF-Pro'),
                    ),
                  if (owner.drove != 0)
                    Text(
                      'Drove: ${owner.drove}',
                      style: TextStyle(fontFamily: 'SF-Pro'),
                    ),
                  Row(
                    children: [
                      Text(
                        'Status: ${owner.status}',
                        style: TextStyle(fontFamily: 'SF-Pro'),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.circle,
                        size: 12,
                        color: _getStatusColor(owner.status),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
