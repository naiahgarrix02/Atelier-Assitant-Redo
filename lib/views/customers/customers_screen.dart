import 'package:atelier_redo/core/constants/app_colors.dart';
import 'package:atelier_redo/widgets/common/atelier_app_bar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AtelierAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Text(
                      'Customers',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
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
                        child: Text('0 customers'),
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
                        decoration: InputDecoration(
                          hintText: 'Search customer or garment...',
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

                SizedBox(height: 24),

                Column(
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
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(18),
                      ),
                      icon: Icon(Icons.add),
                      label: const Text('Add Customer'),
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
