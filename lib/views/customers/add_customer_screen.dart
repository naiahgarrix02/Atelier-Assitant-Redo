import 'package:atelier_redo/core/constants/app_colors.dart';
import 'package:atelier_redo/models/country.dart';
import 'package:atelier_redo/models/customer.dart';
import 'package:material_ui/material_ui.dart';
import 'package:atelier_redo/viewmodels/customer_viewmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

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

  String cleanPhone(String text) {
    final digits = text.replaceAll(RegExp(r'[^0-9]'), ' ');

    final number = digits.startsWith('0') ? digits.substring(1) : digits;
    return number;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone Number is required';
    }

    final number = cleanPhone(value);

    if (selectedCountry.dialCode == '+233' && number.length != 9) {
      return 'Enter 9 digits after +233';
    }
    if (number.length < 7 || number.length > 12) {
      return 'Enter 7 or 12 digits for selected country';
    }

    return null;
  }

  Future<void> pickCountry() async {
    final result = await showModalBottomSheet<Country>(
      context: context,
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: countries.length,
          itemBuilder: ((context, index) {
            final c = countries[index];
            return ListTile(
              leading: Text(c.flag),
              title: Text(c.name),
              trailing: Text(c.dialCode),
              onTap: () => Navigator.pop(context, c),
            );
          }),
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedCountry = result;
      });
    }
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
                    final customer = Customer(
                      id: const Uuid().v4(),
                      name: nameController.text.trim(),
                      phone:
                          '${selectedCountry.dialCode}${cleanPhone(phoneController.text)}',
                      email: emailController.text.isEmpty
                          ? null
                          : emailController.text,
                      notes: notesController.text.isEmpty
                          ? null
                          : notesController.text,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    context.read<CustomerViewModel>().addCustomer(customer);

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Customer saved')));
                    Navigator.pop(context);
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

              SizedBox(height: 32),

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
                              borderRadius: BorderRadius.circular(18),
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
                          validator: validatePhone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: pickCountry,
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
                              borderRadius: BorderRadius.circular(18),
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
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return null;
                            }

                            final email = value.trim();
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(email)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'e.g. jamesjones@email.com',
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
                              borderRadius: BorderRadius.circular(18),
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
                          'Atelier Notes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          maxLines: 5,
                          controller: notesController,
                          decoration: InputDecoration(
                            hintText: 'Special fabric preferences, fit requirements, preferred appointment times, silk sensitivity...',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.textInactive,
                            ),
                            filled: true,
                            fillColor: AppColors.onPrimary,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                color: AppColors.error,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
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
