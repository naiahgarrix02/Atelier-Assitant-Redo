import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';

class AtelierAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AtelierAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Icon(Icons.design_services, color: AppColors.primary),
          Text(
            'Atelier Assistant',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Badge(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.notifications_none_outlined),
          ),
          style: IconButton.styleFrom(padding: EdgeInsets.all(24)),
        ),
      ],
    );
  }
}
