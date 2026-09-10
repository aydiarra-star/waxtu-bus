import 'package:flutter/material.dart';

// ============================================================
// WAXTU BUS — Version 4
// Ajout : 4ème arrêt (Tata 12 → Guédiawaye)
// ============================================================

void main() {
  runApp(const WaxtuBusApp());
}

// ------------------------------------------------------------
// COULEURS WAXTU BUS
// ------------------------------------------------------------
class WaxtuColors {
  static const primary = Color(0xFF00695C);
  static const brt = Color(0xFF1976D2);
  static const ter = Color(0xFF8E1537);
  static const aftu = Color(0xFFEF6C00);
  static const tata = Color(0xFF7B1FA2);
  static const background = Color(0xFFFAFAFA);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B6B6B);
  static const divider = Color(0xFFE0E0E0);
}

// ------------------------------------------------------------
// MODÈLE : Arrêt
// ------------------------------------------------------------
class Stop {
  final String name;
  final String lines;
  final String distance;
  final String schedule;
  final String direction;
  final bool isOfficial;
  final IconData icon;
  final Color color;

  const Stop({
    required this.name,
    required this.lines,
    required this.distance,
    required this.schedule,
    required this.direction,
    required this.isOfficial,
    required this.icon,
    required this.color,
  });
}

// ------------------------------------------------------------
// DONNÉES DE DÉMONSTRATION
// ------------------------------------------------------------
final List<Stop> demoStops = [
  const Stop(
    name: 'BRT Colobane',
    lines: 'B1 · B2 · B3',
    distance: '150 m',
    schedule: '16h25 — dans 7 min',
    direction: 'Petersen',
    isOfficial: true,
    icon: Icons.directions_bus,
    color: WaxtuColors.brt,
  ),
  const Stop(
    name: 'AFTU Ligne 23',
    lines: 'Direction Plateau',
    distance: '280 m',
    schedule: 'Passage estimé vers 16h35',
    direction: 'Plateau',
    isOfficial: false,
    icon: Icons.directions_bus_filled,
    color: WaxtuColors.aftu,
  ),
  const Stop(
    name: 'Gare TER Colobane',
    lines: 'Direction Dakar',
    distance: '620 m',
    schedule: 'Prochain départ 17h35',
    direction: 'Dakar',
    isOfficial: true,
    icon: Icons.train,
    color: WaxtuColors.ter,
  ),
  const Stop(
    name: 'Tata 12',
    lines: 'Direction Guédiawaye',
    distance: '850 m',
    schedule: 'Passage estimé vers 16h50',
    direction: 'Guédiawaye',
    isOfficial: false,
    icon: Icons.directions_bus_filled,
    color: WaxtuColors.tata,
  ),
];

// ------------------------------------------------------------
// APPLICATION PRINCIPALE
// ------------------------------------------------------------
class WaxtuBusApp extends StatelessWidget {
  const WaxtuBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WAXTU BUS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: WaxtuColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: WaxtuColors.primary,
          primary: WaxtuColors.primary,
        ),
      ),
      home: const MainShell(),
    );
  }
}

// ------------------------------------------------------------
// COQUILLE PRINCIPALE AVEC BARRE D'ONGLETS
// ------------------------------------------------------------
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomePage(),
          PlaceholderPage(
            title: 'Recherche',
            icon: Icons.search,
            message: 'Recherchez un arrêt ou une ligne',
          ),
          PlaceholderPage(
            title: 'Carte',
            icon: Icons.map,
            message: 'Vos arrêts sur la carte',
          ),
          PlaceholderPage(
            title: 'Alertes',
            icon: Icons.notifications,
            message: 'Vos alertes de passage',
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: WaxtuColors.surface,
        indicatorColor: WaxtuColors.primary.withValues(alpha: 0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: WaxtuColors.primary),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, color: WaxtuColors.primary),
            label: 'Recherche',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map, color: WaxtuColors.primary),
            label: 'Carte',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon:
                Icon(Icons.notifications, color: WaxtuColors.primary),
            label: 'Alertes',
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// PAGE PLACEHOLDER
// ------------------------------------------------------------
class PlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String message;

  const PlaceholderPage({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WaxtuColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: WaxtuColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 72, color: WaxtuColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: WaxtuColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Bientôt disponible',
              style: TextStyle(
                fontSize: 13,
                color: WaxtuColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// ÉCRAN D'ACCUEIL
// ------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WaxtuColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.location_on,
                        color: WaxtuColors.primary, size: 20),
                    SizedBox(width: 4),
                    Text(
                      'Colobane',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: WaxtuColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Où allez-vous ?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: WaxtuColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: WaxtuColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher un arrêt, une ligne...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Près de vous',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: WaxtuColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ...demoStops.map((stop) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StopCard(stop: stop),
                    )),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// COMPOSANT : Carte d'arrêt (cliquable)
// ------------------------------------------------------------
class StopCard extends StatelessWidget {
  final Stop stop;

  const StopCard({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StopDetailPage(stop: stop),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: WaxtuColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: stop.color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(stop.icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    stop.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: WaxtuColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  stop.distance,
                  style: const TextStyle(
                    fontSize: 14,
                    color: WaxtuColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Text(
                stop.lines,
                style: const TextStyle(
                  fontSize: 14,
                  color: WaxtuColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      stop.schedule,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: WaxtuColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    stop.isOfficial ? '🟢' : '🟡',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// ÉCRAN DE DÉTAIL D'UN ARRÊT
// ------------------------------------------------------------
class StopDetailPage extends StatelessWidget {
  final Stop stop;

  const StopDetailPage({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WaxtuColors.background,
      appBar: AppBar(
        title: Text(stop.name),
        backgroundColor: stop.color,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: stop.color,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(stop.icon,
                          color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: WaxtuColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          '${stop.distance} de vous',
                          style: const TextStyle(
                            fontSize: 14,
                            color: WaxtuColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Direction',
                style: TextStyle(
                  fontSize: 14,
                  color: WaxtuColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stop.direction,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: WaxtuColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Prochains passages',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: WaxtuColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _departureRow('16h25', 'dans 7 min', stop.isOfficial),
              _departureRow('16h31', 'dans 13 min', stop.isOfficial),
              _departureRow('16h37', 'dans 19 min', stop.isOfficial),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🔔 Alerte activée — 10 min avant'),
                        backgroundColor: WaxtuColors.primary,
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_active),
                  label: const Text('Me prévenir 10 min avant'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WaxtuColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  stop.isOfficial
                      ? '🟢 Données officielles'
                      : '🟡 Données estimées',
                  style: const TextStyle(
                    fontSize: 13,
                    color: WaxtuColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _departureRow(String time, String countdown, bool isOfficial) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: WaxtuColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: WaxtuColors.textPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            countdown,
            style: const TextStyle(
              fontSize: 15,
              color: WaxtuColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            isOfficial ? '🟢' : '🟡',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}