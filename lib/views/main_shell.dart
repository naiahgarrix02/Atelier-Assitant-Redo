import 'package:atelier_redo/core/constants/app_colors.dart';
import 'package:atelier_redo/views/archives/archives_screen.dart';
import 'package:atelier_redo/views/dashboard/dashboard_screen.dart';
import 'package:atelier_redo/views/customers/customers_screen.dart';
import 'package:atelier_redo/views/measurements/measurements_screen.dart';
import 'package:material_ui/material_ui.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    DashboardScreen(),
    CustomersScreen(),
    MeasurementsScreen(),
    ArchivesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: AppColors.card,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                label: 'Home',
                isSelected: selectedIndex == 0,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              _NavItem(
                icon: Icons.people_outlined,
                label: 'Customers',
                isSelected: selectedIndex == 1,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              _NavItem(
                icon: Icons.straighten,
                label: 'Measurements',
                isSelected: selectedIndex == 2,
                onTap: () => setState(() => selectedIndex = 2),
              ),
              _NavItem(
                icon: Icons.inventory_2_outlined,
                label: 'Archived',
                isSelected: selectedIndex == 3,
                onTap: () => setState(() => selectedIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: AnimatedSize(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.onPrimary : AppColors.textPrimary,
              ),
              if (isSelected)
                Text(label, style: TextStyle(color: AppColors.onPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}
