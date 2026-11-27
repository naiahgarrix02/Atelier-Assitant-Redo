import 'package:atelier_redo/core/constants/app_colors.dart';
import 'package:atelier_redo/views/customers/add_customer_screen.dart';
import 'package:atelier_redo/widgets/common/atelier_app_bar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:atelier_redo/widgets/customers/customer_tile.dart';
import 'package:provider/provider.dart';
import 'package:atelier_redo/viewmodels/customer_viewmodel.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  String query = '';
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final customers = context.watch<CustomerViewModel>().customers;

    final labels = ['All', 'Recently Added', 'Recently Updated'];
    final cutoff = DateTime.now().subtract(const Duration(days: 3));

    final allCustomers = customers;

    final newCustomers = customers.where((c) {
      return c.createdAt.isAfter(cutoff);
    }).toList();

    final updatedCustomers = customers.where((c) {
      return c.updatedAt.isAfter(cutoff);
    }).toList();

    final chipList = switch (selectedFilter) {
      0 => allCustomers,
      1 => newCustomers,
      _ => updatedCustomers,
    };

    final filtered = chipList.where((c) {
      return c.name.toLowerCase().contains(query.toLowerCase()) ||
          c.phone.contains(query);
    }).toList();
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final counts = [
      allCustomers.length,
      newCustomers.length,
      updatedCustomers.length,
    ];

    return Scaffold(
      floatingActionButton: customers.isEmpty
          ? null
          : FloatingActionButton.extended(
              shape: StadiumBorder(side: BorderSide(color: AppColors.border)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCustomerScreen()),
                );
              },
              label: Row(
                spacing: 8,
                children: [Icon(Icons.add), Text('Add Customer')],
              ),
            ),
      appBar: AtelierAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                spacing: 16,
                children: [
                  Text(
                    'Customers',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.mint,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text('${customers.length} customer(s)'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search customer or phone...',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: AppColors.textInactive,
                        ),
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: AppColors.onPrimary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16),
                    ),
                    icon: Icon(Icons.tune),
                  ),
                ],
              ),

              SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: [
                    ...List.generate(
                      labels.length,
                      (i) => ChoiceChip(
                        label: Text('${labels[i]} (${counts[i]})'),
                        showCheckmark: false,
                        shape: StadiumBorder(
                          side: BorderSide(color: AppColors.border),
                        ),
                        selected: selectedFilter == i,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.card,
                        labelStyle: TextStyle(
                          color: selectedFilter == i
                              ? AppColors.onPrimary
                              : AppColors.textPrimary,
                          fontSize: 16,
                        ),
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        onSelected: (bool value) {
                          setState(() {
                            selectedFilter = i;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: customers.isEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/no_customers.svg',
                              width: 200,
                              height: 200,
                            ),

                            Text(
                              'No Customers Yet',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 12),
                            SizedBox(
                              width: 300,
                              child: Text(
                                'Start building your atelier client list. Save measurements, track garment fittings, and keep bespoke notes all in one place.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),

                            SizedBox(height: 24),

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
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: ((context, index) {
                          return CustomerTile(
                            customer: filtered[index],
                            onTap: () {},
                          );
                        }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
