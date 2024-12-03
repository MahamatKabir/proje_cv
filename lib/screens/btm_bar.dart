import 'package:flutter/material.dart';
import 'package:projet_cv/screens/home_page.dart';
import 'package:projet_cv/screens/home_screen.dart';
import 'package:projet_cv/screens/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Liste des pages à afficher
  final List<Widget> _pages = [
    const HomePage(),
    const HomeScreen(),
    const ProfilePage(),
  ];

  // Fonction pour changer la page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType
            .fixed, // Changez à `.shifting` si vous voulez une animation
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Créer CV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.blue, // Couleur de l'élément sélectionné
        unselectedItemColor: Colors.grey, // Couleur des autres éléments
      ),
    );
  }
}
