import 'package:atelier_redo/core/constants/app_colors.dart';
import 'package:atelier_redo/models/country.dart';
import 'package:material_ui/material_ui.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final notesController = TextEditingController();

  Country selectedCountry = countries.first;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    notesController.dispose();

    super.dispose();
  }

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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton.icon(
                label: Text('Save Customer', style: TextStyle(fontSize: 18)),
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(52),
                  padding: EdgeInsets.all(18),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('valid');
                  }
                },
                icon: Icon(Icons.check),
              ),
              SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(52),
                  padding: EdgeInsets.all(18),
                ),
                child: Text(
                  'Cancel and Discard',
                  style: TextStyle(color: AppColors.onMint, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24),
              Center(
                child: Stack(
                  children: [
                    Material(
                      color: AppColors.mint,
                      shape: CircleBorder(
                        side: BorderSide(color: AppColors.border, width: 2),
                      ),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          print('Avatar tapped');
                        },
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: Icon(Icons.person_outline, size: 50),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IgnorePointer(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 16,
                            color: AppColors.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Center(
                child: Text(
                  'Add Client Monogram or photo',
                  style: TextStyle(fontSize: 16, color: AppColors.onMint),
                ),
              ),

              SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required to save a customer profile';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'e.g. James Jones',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.textInactive,
                            ),
                            filled: true,
                            fillColor: AppColors.onPrimary,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 1.5,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: AppColors.error,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        SizedBox(height: 28),

                        Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: phoneController,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Phone is required to save a customer profile';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8,
                                  children: [
                                    Text(selectedCountry.flag),
                                    Text(selectedCountry.dialCode),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                              ),
                            ),
                            hintText: 'e.g. +233 20 222 2222',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.textInactive,
                            ),
                            filled: true,
                            fillColor: AppColors.onPrimary,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 1.5,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: AppColors.error,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
