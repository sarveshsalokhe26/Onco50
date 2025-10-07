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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Onco50HomePage(
            onQuickActionTap: (String action) {
              if (action == "predictor") {
                _onItemTapped(1); // Switch to Predictor tab
              } else if (action == "dashboard") {
                _onItemTapped(2); // Switch to Dashboard tab
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green.shade900,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: "Predictor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  // Custom slide transition navigator
  void _navigateWithSlide(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1.0, 0.0); // start from right
          const end = Offset.zero; // end in place
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Onco50 Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Onco50",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "A compassionate space to track your health, connect with supportive communities, and access trusted care — because no one should face cancer alone.",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Welcome Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back, Sarvesh",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Quick Action Grid
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _quickAction(
                      Icons.science,
                      "PREDICT IC50\nVALUE",
                      "predictor",
                      onQuickActionTap,
                    ),
                    _quickAction(
                      Icons.description,
                      "TRACK\nCONSENTS",
                      "consent",
                      onQuickActionTap,
                    ),
                    _quickAction(
                      Icons.dashboard,
                      "DASHBOARD",
                      "dashboard",
                      onQuickActionTap,
                    ),
                    _quickAction(
                      Icons.people,
                      "PATIENTS",
                      "patients",
                      onQuickActionTap,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Community Section
          const Text(
            "From the community",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey, radius: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Riya shared her recovery journey",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable quick action
  static Widget _quickAction(
    IconData icon,
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
            children: [
              Icon(icon, color: Colors.black87),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
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
