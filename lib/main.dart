import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF00B4C8),
        scaffoldBackgroundColor: const Color(0xFF0A0C10),
        cardColor: const Color(0xFF11151C),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00B4C8),
          secondary: Color(0xFFC19A5B),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ────────────────────────────── Welcome Screen ──────────────────────────────
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF00B4C8),
                    Color(0xFF40D0E0),
                    Color(0xFFC19A5B)
                  ],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Optimizer',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Engineered performance.\nCinematic efficiency.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 19,
                    color: Color(0xFF8A98A8),
                    fontWeight: FontWeight.w300,
                    height: 1.4),
              ),
              const Spacer(flex: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4C8),
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 8,
                ),
                child: const Text('Get Started',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
              const Text(
                'Software-level optimization only.\nFull control always yours.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, color: Color(0xFF8A98A8), height: 1.6),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────── Dashboard Screen (Dynamic) ──────────────────────────────
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _batteryLevel = 75;
  double _cpuTemp = 36.5;
  bool _powerSaving = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startUpdates();
  }

  void _startUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _batteryLevel =
            (_batteryLevel + (Random().nextInt(5) - 2)).clamp(15, 100);
        _cpuTemp = (_cpuTemp + (Random().nextDouble() - 0.5)).clamp(32.0, 48.0);
        _powerSaving = _batteryLevel < 30;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLowBattery = _batteryLevel < 30;
    final isHighTemp = _cpuTemp > 42;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Optimizer',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.8,
                        color: Color(0xFF00B4C8)),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings_outlined),
                        color: Colors.white70,
                        onPressed: () => HapticFeedback.lightImpact(),
                      ),
                      if (isHighTemp)
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: const Icon(Icons.warning,
                                color: Colors.white, size: 12),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF11151C),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: isLowBattery
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFF00B4C8)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B4C8).withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.bolt,
                          color: const Color(0xFF00B4C8), size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _powerSaving
                                  ? 'Power Saving Active'
                                  : 'Battery Optimized',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(
                              '${_batteryLevel}% • ${_cpuTemp.toStringAsFixed(1)}°C',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white60)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 500;
                    return GridView.count(
                      crossAxisCount: isWide ? 2 : 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: isWide ? 1.65 : 2.9,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 24),
                      children: [
                        FeatureTile(
                          title: 'Battery Power Saving',
                          icon: Icons.bolt,
                          status: _powerSaving
                              ? 'Power Saving ON'
                              : 'Monitoring Active',
                          color: const Color(0xFF00B4C8),
                          detailScreen: BatteryPowerSavingDetail(
                              batteryLevel: _batteryLevel),
                        ),
                        const FeatureTile(
                          title: 'Idle App Detection',
                          icon: Icons.hourglass_bottom,
                          status: '3 apps idle detected',
                          color: Color(0xFF6B7280),
                          detailScreen: IdleAppDetectionDetail(),
                        ),
                        const FeatureTile(
                          title: 'Cache Cleanup',
                          icon: Icons.cleaning_services,
                          status: '245 MB available',
                          color: Color(0xFF10B981),
                          detailScreen: CacheCleanupDetail(),
                        ),
                        const FeatureTile(
                          title: 'High Usage',
                          icon: Icons.monitor_heart,
                          status: 'High screen usage detected',
                          color: Color(0xFFF59E0B),
                          detailScreen: HighUsageDetail(),
                        ),
                        FeatureTile(
                          title: 'Night Mode',
                          icon: Icons.dark_mode,
                          status: _isNightTime()
                              ? 'Night mode active'
                              : 'Day mode active',
                          color: const Color(0xFF8B5CF6),
                          detailScreen: const NightModeDetail(),
                        ),
                        const FeatureTile(
                          title: 'Background Limiter',
                          icon: Icons.lock_clock,
                          status: 'Background activity limited',
                          color: Color(0xFFEF4444),
                          detailScreen: BackgroundLimiterDetail(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isNightTime() {
    final hour = DateTime.now().hour;
    return hour >= 22 || hour <= 6;
  }
}

// ────────────────────────────── FeatureTile (Updated) ──────────────────────────────
class FeatureTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String status;
  final Color color;
  final Widget detailScreen;

  const FeatureTile({
    super.key,
    required this.title,
    required this.icon,
    required this.status,
    required this.color,
    required this.detailScreen,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status.contains('ON') ||
        status.contains('active') ||
        status.contains('detected');

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => detailScreen));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF11151C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? color.withOpacity(0.5) : const Color(0xFF1E2A38),
            width: 1.5,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 0)
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? color : Colors.grey[600], size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600, height: 1.1),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              status,
              style: TextStyle(
                fontSize: 13,
                color: isActive ? color.withOpacity(0.9) : Colors.grey[500],
                fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────── Complete Detail Screens ──────────────────────────────
class BatteryPowerSavingDetail extends StatelessWidget {
  final int batteryLevel;
  const BatteryPowerSavingDetail({super.key, required this.batteryLevel});

  @override
  Widget build(BuildContext context) {
    final isLow = batteryLevel < 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Power Saving'),
        backgroundColor: const Color(0xFF0A0C10),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _StatusCard(
            icon: Icons.bolt,
            title: 'Power Saving Mode',
            status: isLow ? 'ACTIVE' : 'STANDBY',
            subtitle: 'Battery: ${batteryLevel}%',
            color: const Color(0xFF00B4C8),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 16,
            child: LinearProgressIndicator(
              value: batteryLevel / 100,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation(
                  isLow ? Colors.orange : const Color(0xFF00B4C8)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('$batteryLevel%',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 32),
          SwitchListTile(
            title: const Text('Power Saving',
                style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle:
                Text(isLow ? 'Auto-enabled (Low battery)' : 'Enable manually'),
            value: isLow,
            activeColor: const Color(0xFF00B4C8),
            onChanged: (value) {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('Power saving ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              '• Limits background apps\n• Reduces animations\n• Optimizes CPU usage',
              style: TextStyle(height: 1.5, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class IdleAppDetectionDetail extends StatelessWidget {
  const IdleAppDetectionDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Idle App Detection'),
          backgroundColor: const Color(0xFF0A0C10)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF11151C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.hourglass_bottom,
                    color: Color(0xFF6B7280), size: 32),
                SizedBox(width: 16),
                Expanded(
                    child: Text('3 Idle Apps Detected',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Unused for 14+ days:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          _AppItem('Facebook', '18 days'),
          _AppItem('Instagram', '25 days'),
          _AppItem('Old Games', '42 days'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                HapticFeedback.mediumImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Limiting idle apps')));
              },
              icon: const Icon(Icons.stop_circle),
              label: const Text('Limit Idle Apps'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _AppItem(String name, String days) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF6B7280).withOpacity(0.2),
          child: const Icon(Icons.apps, color: Color(0xFF6B7280)),
        ),
        title: Text(name),
        subtitle:
            Text('$days unused', style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class CacheCleanupDetail extends StatefulWidget {
  const CacheCleanupDetail({super.key});
  @override
  State<CacheCleanupDetail> createState() => _CacheCleanupDetailState();
}

class _CacheCleanupDetailState extends State<CacheCleanupDetail> {
  double _cacheSize = 245.0;
  bool _clearing = false;

  Future<void> _clearCache() async {
    setState(() => _clearing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _cacheSize = (_cacheSize * 0.4).clamp(0.0, 100.0);
      _clearing = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cleared ${_cacheSize.toStringAsFixed(0)} MB')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Cache Cleanup'),
          backgroundColor: const Color(0xFF0A0C10)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xFF11151C),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(Icons.cleaning_services,
                    color: Color(0xFF10B981), size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cache Cleanup',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('${_cacheSize.toStringAsFixed(0)} MB',
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFF10B981))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Top Cache Users:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          _CacheItem('Facebook', '120 MB'),
          _CacheItem('WhatsApp', '65 MB'),
          _CacheItem('Browser', '42 MB'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _clearing ? null : _clearCache,
              icon: _clearing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.cleaning_services),
              label: Text(_clearing ? 'Clearing...' : 'Clear All Cache'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _CacheItem(String app, String size) {
    return ListTile(
      leading: const Icon(Icons.folder, color: Color(0xFF10B981)),
      title: Text(app),
      trailing: Text(size,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF10B981))),
    );
  }
}

class HighUsageDetail extends StatelessWidget {
  const HighUsageDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('High Usage Monitor'),
          backgroundColor: const Color(0xFF0A0C10)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _StatusCard(
            icon: Icons.monitor_heart,
            title: 'Screen Time',
            status: 'HIGH',
            subtitle: '2h 47m today',
            color: const Color(0xFFF59E0B),
          ),
          const SizedBox(height: 32),
          const Text('Today\'s Usage:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          _UsageItem('Social Media', '1h 12m', const Color(0xFF3B82F6)),
          _UsageItem('Games', '45m', const Color(0xFF10B981)),
          _UsageItem('Browser', '32m', const Color(0xFFEF4444)),
          const SizedBox(height: 32),
          SwitchListTile(
            title: const Text('Usage Limits',
                style: TextStyle(fontWeight: FontWeight.w600)),
            value: false,
            activeColor: const Color(0xFFF59E0B),
            onChanged: (_) {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Usage limits enabled')));
            },
          ),
        ],
      ),
    );
  }

  Widget _UsageItem(String app, String time, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(Icons.smartphone, color: color)),
        title: Text(app),
        trailing:
            Text(time, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class NightModeDetail extends StatefulWidget {
  const NightModeDetail({super.key});
  @override
  State<NightModeDetail> createState() => _NightModeDetailState();
}

class _NightModeDetailState extends State<NightModeDetail> {
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _enabled = DateTime.now().hour >= 22 || DateTime.now().hour <= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Night Efficiency Mode'),
          backgroundColor: const Color(0xFF0A0C10)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _StatusCard(
            icon: Icons.dark_mode,
            title: 'Night Mode',
            status: _enabled ? 'ACTIVE' : 'OFF',
            subtitle: 'Reduces eye strain & power',
            color: const Color(0xFF8B5CF6),
          ),
          const SizedBox(height: 32),
          SwitchListTile(
            title: const Text('Night Efficiency Mode',
                style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text('Auto 10PM - 6AM'),
            value: _enabled,
            activeColor: const Color(0xFF8B5CF6),
            onChanged: (value) {
              setState(() => _enabled = value);
              HapticFeedback.lightImpact();
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              '• Warmer screen colors\n• Reduced brightness\n• Blue light filter',
              style: TextStyle(height: 1.5, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundLimiterDetail extends StatelessWidget {
  const BackgroundLimiterDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Background Activity Limiter'),
          backgroundColor: const Color(0xFF0A0C10)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _StatusCard(
            icon: Icons.lock_clock,
            title: 'Background Limiter',
            status: 'ACTIVE',
            subtitle: '5 apps limited',
            color: const Color(0xFFEF4444),
          ),
          const SizedBox(height: 32),
          const Text('Currently Limited:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          _LimitedApp('Music Player', 'Limited'),
          _LimitedApp('Weather', 'Limited'),
          _LimitedApp('Maps', 'Limited'),
          const SizedBox(height: 32),
          SwitchListTile(
            title: const Text('Background Limiter',
                style: TextStyle(fontWeight: FontWeight.w600)),
            value: true,
            activeColor: const Color(0xFFEF4444),
            onChanged: (value) {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Limiter ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _LimitedApp(String name, String status) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.lock_clock, color: Color(0xFFEF4444)),
        title: Text(name),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(status, style: const TextStyle(color: Color(0xFFEF4444))),
        ),
      ),
    );
  }
}

// ────────────────────────────── Reusable Status Card ──────────────────────────────
class _StatusCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String status;
  final String subtitle;
  final Color color;

  const _StatusCard({
    required this.icon,
    required this.title,
    required this.status,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF11151C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 56),
          const SizedBox(height: 16),
          Text(title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(status,
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.white70)),
        ],
      ),
    );
  }
}
