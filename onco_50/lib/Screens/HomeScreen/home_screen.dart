import 'package:flutter/material.dart';
import '../PredictorScreen/predictor_page.dart';
import '../AccountScreen/account_screen.dart';
import '../ConsentTrackingScreen/consent_tracking_page.dart';
import '../DashboardScreen/dashboard_screen.dart';
import '../PatientsScreen/patients_page.dart';

class Onco50App extends StatefulWidget {
  const Onco50App({super.key});

  @override
  State<Onco50App> createState() => _Onco50AppState();
}

class _Onco50AppState extends State<Onco50App> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/HomePageBagroundImage/14e7dfd9d58b6949dc93ed6e77c6980f.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          IndexedStack(
            index: _selectedIndex,
            children: [
              Onco50HomePage(
                onQuickActionTap: (String action) {
                  if (action == "predictor") {
                    _onItemTapped(1);
                  } else if (action == "dashboard") {
                    _onItemTapped(2);
                  } else if (action == "consent") {
                    _navigateWithSlide(context, const ConsentPage());
                  } else if (action == "patients") {
                    _navigateWithSlide(context, const PatientsPage());
                  }
                },
              ),
              const PredictorPage(),
              const DashboardPage(),
              const AccountPage(),
            ],
          ),

          // Floating bottom navigation bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: 379,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navBarItem(
                      "assets/NavigationBarIcons/home.png",
                      "Home",
                      0,
                    ),
                    _navBarItem(
                      "assets/NavigationBarIcons/predictive-chart.png",
                      "Predictor",
                      1,
                    ),
                    _navBarItem(
                      "assets/NavigationBarIcons/dashboard (6).png",
                      "Dashboard",
                      2,
                    ),
                    _navBarItem(
                      "assets/NavigationBarIcons/user (1).png",
                      "Account",
                      3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navBarItem(String iconPath, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 28,
            height: 28,
            color: isSelected ? null : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.green.shade900 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateWithSlide(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}

/// ----------------- HOME PAGE -----------------
class Onco50HomePage extends StatelessWidget {
  final Function(String action)? onQuickActionTap;
  const Onco50HomePage({super.key, this.onQuickActionTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // Onco50 Header
          Container(
            width: 379,
            height: 166,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(80, 117, 62, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0),
                Text(
                  "Onco50",
                  style: TextStyle(
                    fontFamily: 'AlegreyaSansSC',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "A compassionate space to track your health, connect with supportive communities, and access trusted care because no one should face cancer alone.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'AlegreyaSansSC',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Welcome Section
          Container(
            width: 379,
            height: 284,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(50, 68, 48, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back, Sarvesh",
                  style: TextStyle(
                    fontFamily: 'AlegreyaSansSC',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 0),

                // Quick Action Grid with PNGs and overflow fix
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _quickAction(
                      "assets/NavigationBarIcons/predictive-chart.png",
                      "PREDICT IC50\nVALUE",
                      "predictor",
                      onQuickActionTap,
                    ),
                    _quickAction(
                      "assets/NavigationBarIcons/donor-consent-form.png",
                      "TRACK\nCONSENTS",
                      "consent",
                      onQuickActionTap,
                    ),
                    _quickAction(
                      "assets/NavigationBarIcons/dashboard (6).png",
                      "DASHBOARD",
                      "dashboard",
                      onQuickActionTap,
                    ),
                    _quickAction(
                      "assets/NavigationBarIcons/medical-record.png",
                      "PATIENTS",
                      "patients",
                      onQuickActionTap,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Community Section
          const Text(
            "  From the community",
            style: TextStyle(
              fontFamily: 'AlegreyaSansSC',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(42, 57, 32, 1),
            ),
          ),
          const SizedBox(height: 4),

          Container(
            width: 379,
            height: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: const Color.fromRGBO(80, 117, 62, 0.90),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey, radius: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Riya shared her recovery journey",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _quickAction(
    String iconPath,
    String title,
    String action,
    Function(String action)? onTap,
  ) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap(action);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // prevent overflow
            children: [
              Image.asset(iconPath, width: 30, height: 30),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
