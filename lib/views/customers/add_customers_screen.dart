import 'package:atelier_redo/core/constants/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class AddCustomersScreen extends StatefulWidget {
  const AddCustomersScreen({super.key});

  @override
  State<AddCustomersScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          'Add Customer',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.mint,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person_outline, size: 40),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.add_a_photo_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
