import 'package:atelier_redo/views/customers/add_customer_screen.dart';
import 'package:atelier_redo/widgets/common/atelier_app_bar.dart';
import 'package:atelier_redo/widgets/customers/customer_tile.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_colors.dart';
import '../../models/customer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Customer> customers = [
      Customer(
        id: '0001',
        name: 'Ivan',
        phone: '+233 54 867 8964',
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: '0002',
        name: 'Elise',
        phone: '+233 54 867 8964',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: '0003',
        name: 'Jacob',
        phone: '+233 54 867 8964',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: '0004',
        name: 'Kevin',
        phone: '+233 54 867 8964',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: '0005',
        name: 'Myles',
        phone: '+233 54 867 8964',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: '0006',
        name: 'Wendy',
        phone: '+233 54 867 8964',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
      ),
      Customer(
        id: '0007',
        name: 'Irene',
        phone: '+233 54 867 8964',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    final sorted = [...customers];
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final recentCustomers = sorted.take(4).toList();

    return Scaffold(
      appBar: const AtelierAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Morning, User',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Ready for today\'s fittings?',
                  style: TextStyle(color: AppColors.textMuted),
                ),

                const SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search customer or garment...',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: AppColors.textInactive,
                    ),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(4),
                      child: IconButton.filledTonal(
                        onPressed: () {},
                        icon: Icon(Icons.tune),
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.onPrimary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.mint,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ACTIVE ROSTER'),
                              SizedBox(height: 2),
                              Row(
                                spacing: 12,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${customers.length}',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    'customer(s)',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/icons/customers_icon.svg',
                            width: 48,
                            height: 48,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        spacing: 12,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.onPrimary,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Row(
                              spacing: 8,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  color: AppColors.primary,
                                ),
                                Text(
                                  '+0 this month',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Row(
                              spacing: 8,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.checkroom,
                                  color: AppColors.onPrimary,
                                ),
                                Text(
                                  '0 fitting schedules',
                                  style: TextStyle(
                                    color: AppColors.onPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12),

                Row(
                  spacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCustomerScreen(),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(18),
                      ),
                      icon: Icon(Icons.add),
                      label: const Text('Add Customer'),
                    ),
                    FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        minimumSize: Size(0, 52),
                      ),
                      onPressed: () {},
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.straighten),
                          Text('Measurements'),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recent Customers',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32),

                    customers.isEmpty
                        ? Column(
                            children: [
                              Icon(
                                Icons.no_accounts,
                                color: AppColors.textInactive,
                                size: 60,
                              ),

                              SizedBox(height: 12),

                              SizedBox(
                                width: 300,
                                child: Text(
                                  'No customers to show.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ...recentCustomers.map(
                                (c) => CustomerTile(customer: c, onTap: () {}),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
