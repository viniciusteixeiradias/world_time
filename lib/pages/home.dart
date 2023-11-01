import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    String bgImage = data['isDaytime'] ? 'day.jpeg' : 'night.jpeg';
    Color textColor = data['isDaytime'] ? Colors.black : const Color.fromARGB(255, 231, 231, 231);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: textColor
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: textColor
                    ),
                  )
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28,
                        color: textColor
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 60,
                    color: textColor
                  )
                )
              ],
            ),
          ),
        )
      )
    );
  }
}