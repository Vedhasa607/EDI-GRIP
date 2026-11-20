import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const SmartGloveApp());
}

class SmartGloveApp extends StatelessWidget {
  const SmartGloveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Glove',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08110F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF42D392),
          brightness: Brightness.dark,
        ),
        textTheme: ThemeData.dark().textTheme,
      ),
      home: const MainNavigation(),
    );
  }
}
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    InjectionScreen(),
    HistoryScreen(),
    InsightsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF0D1916),
        indicatorColor: const Color(0xFF183C32),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services),
            label: 'Inject',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Insights',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Text(
              'Good evening, Vedhasa 👋',
              style: GoogleFonts.dmSans(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Here is your injection overview.',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            _nextInjectionCard(context),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: _statusCard(
                    Icons.bluetooth_connected,
                    'Glove',
                    'Connected',
                    true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statusCard(
                    Icons.battery_5_bar,
                    'Battery',
                    '82%',
                    true,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              "Today's Status",
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _metricCard(
                    '2',
                    'Completed',
                    Icons.check_circle_outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _metricCard(
                    '2',
                    'Successful',
                    Icons.verified_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _metricCard(
              '87%',
              'Average Steadiness',
              Icons.pan_tool_alt_outlined,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Later navigate to injection screen
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'Start Injection',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF42D392),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'Recent Activity',
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _activityTile(
              'Injection completed',
              'Today • 8:02 PM',
              '91%',
              Icons.check_circle,
            ),

            _activityTile(
              'Injection completed',
              'Yesterday • 8:05 PM',
              '84%',
              Icons.check_circle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nextInjectionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF12382E),
            Color(0xFF10231F),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF245C4C),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NEXT INJECTION',
            style: TextStyle(
              color: Color(0xFF42D392),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '8:00 PM',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Today',
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(
      IconData icon,
      String title,
      String value,
      bool connected,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: connected
                ? const Color(0xFF42D392)
                : Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade400),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricCard(
      String value,
      String label,
      IconData icon,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF42D392),
            size: 30,
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activityTile(
      String title,
      String subtitle,
      String score,
      IconData icon,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF42D392),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            score,
            style: const TextStyle(
              color: Color(0xFF42D392),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
class InjectionScreen extends StatefulWidget {
  const InjectionScreen({super.key});

  @override
  State<InjectionScreen> createState() => _InjectionScreenState();
}

class _InjectionScreenState extends State<InjectionScreen> {
  int stage = 0;

  final List<String> stages = [
    'Get Steady',
    'Position',
    'Injection',
    'Complete',
  ];

  final List<String> descriptions = [
    'Keep your hand steady.',
    'Place the pen against the skin.',
    'Press the plunger slowly.',
    'Injection completed successfully.',
  ];

  final List<IconData> icons = [
    Icons.pan_tool_outlined,
    Icons.gps_fixed,
    Icons.touch_app_outlined,
    Icons.check_circle_outline,
  ];

  @override
  Widget build(BuildContext context) {
    double progress = (stage + 1) / stages.length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              'Guided Injection',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Follow the steps carefully.',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),

            const SizedBox(height: 30),

            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey.shade800,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF42D392),
              ),
            ),

            const SizedBox(height: 35),

            Center(
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF102B24),
                  border: Border.all(
                    color: const Color(0xFF42D392),
                    width: 3,
                  ),
                ),
                child: Icon(
                  icons[stage],
                  size: 75,
                  color: const Color(0xFF42D392),
                ),
              ),
            ),

            const SizedBox(height: 35),

            Center(
              child: Text(
                stages[stage],
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: Text(
                descriptions[stage],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (stage == 0)
              _infoBox(
                Icons.hourglass_top,
                'Waiting for stable hand position...',
              ),

            if (stage == 1)
              _infoBox(
                Icons.contact_page_outlined,
                'Waiting for contact detection...',
              ),

            if (stage == 2)
              _infoBox(
                Icons.touch_app,
                'Contact detected. Press slowly.',
              ),

            if (stage == 3)
              _infoBox(
                Icons.celebration_outlined,
                'Great! Your injection session is complete.',
              ),

            const Spacer(),

            if (stage < 3)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      stage++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF42D392),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    stage == 0
                        ? 'Hand is Steady'
                        : stage == 1
                        ? 'Contact Detected'
                        : 'Complete Injection',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            if (stage == 3)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      stage = 0;
                    });
                  },
                  child: const Text('Start New Session'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(IconData icon, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF42D392),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = [
      ['Today', '8:02 PM', '91%', '10 sec', 'Success'],
      ['Yesterday', '8:05 PM', '84%', '12 sec', 'Success'],
      ['Sept 8', '1:10 PM', '67%', '6 sec', 'Warning'],
      ['Sept 7', '8:01 PM', '89%', '11 sec', 'Success'],
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Injection History',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your previous injection sessions.',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),

            const SizedBox(height: 25),

            ...sessions.map(
                  (session) => _historyCard(session),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyCard(List<String> session) {
    bool success = session[4] == 'Success';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                success
                    ? Icons.check_circle
                    : Icons.warning_amber_rounded,
                color: success
                    ? const Color(0xFF42D392)
                    : Colors.orange,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      session[1],
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                session[4],
                style: TextStyle(
                  color: success
                      ? const Color(0xFF42D392)
                      : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Divider(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _smallStat('Steadiness', session[2]),
              _smallStat('Duration', session[3]),
              _smallStat(
                'Contact',
                'Detected',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Insights',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Understand your injection performance.',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: _insightCard(
                    '87%',
                    'Avg. Steadiness',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _insightCard(
                    '8%',
                    'Weekly Improvement',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF101D1A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Steadiness Trend',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    height: 220,
                    child: LineChart(
                      LineChartData(
                        minY: 50,
                        maxY: 100,
                        gridData: const FlGridData(
                          show: true,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        titlesData: const FlTitlesData(
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            spots: const [
                              FlSpot(0, 72),
                              FlSpot(1, 78),
                              FlSpot(2, 75),
                              FlSpot(3, 84),
                              FlSpot(4, 81),
                              FlSpot(5, 91),
                              FlSpot(6, 87),
                            ],
                            barWidth: 4,
                            dotData: const FlDotData(
                              show: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _insightMessage(
              Icons.trending_up,
              'Your steadiness improved by 8% this week.',
            ),

            _insightMessage(
              Icons.warning_amber_rounded,
              'You had 2 stability warnings this week.',
            ),

            _insightMessage(
              Icons.verified_outlined,
              '4 out of 5 recent sessions were successful.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _insightCard(String value, String title) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF42D392),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _insightMessage(
      IconData icon,
      String message,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF42D392),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF101D1A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Color(0xFF183C32),
                    child: Icon(
                      Icons.person,
                      size: 42,
                      color: Color(0xFF42D392),
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Vedhasa',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Smart Glove User',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Glove Status',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _sensorTile(
              Icons.bluetooth_connected,
              'Bluetooth',
              'Connected',
              true,
            ),

            _sensorTile(
              Icons.sensors,
              'MPU6050',
              'Connected',
              true,
            ),

            _sensorTile(
              Icons.touch_app,
              'Contact FSR',
              'Ready',
              true,
            ),

            _sensorTile(
              Icons.compress,
              'Plunger FSR',
              'Ready',
              true,
            ),

            _sensorTile(
              Icons.battery_5_bar,
              'Battery',
              '82%',
              true,
            ),

            const SizedBox(height: 25),

            const Text(
              'Personal Calibration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              tileColor: const Color(0xFF101D1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: const Icon(
                Icons.tune,
                color: Color(0xFF42D392),
              ),
              title: const Text(
                'Run Calibration',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Update your personal steadiness profile',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _sensorTile(
      IconData icon,
      String title,
      String value,
      bool active,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF101D1A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF42D392),
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: TextStyle(
            color: active
                ? const Color(0xFF42D392)
                : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}