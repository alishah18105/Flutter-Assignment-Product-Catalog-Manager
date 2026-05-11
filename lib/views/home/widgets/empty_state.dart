import 'package:flutter/material.dart';
import 'package:provicer_api_project/core/theme/app_themes.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
       
        children: [
          SizedBox(height: 50),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.textFieldBackground,
            ),
            child: const Center(
              child: Icon(
                Icons.inventory_2_outlined,
                size: 80,
                color: Colors.grey,
              ),
            ),
          ),
      
          const SizedBox(height: 20),
      
          const Text(
            "No Product Found",
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
      
          const SizedBox(height: 10),
      
          Text(
            "Your workplace is currently a clean slate. Start by adding your first product to the inventory.",
            textAlign: TextAlign.center, 
            style: TextStyle(
              color: AppColors.hintText,
            ),
          ),
        ],
      ),
    );
  }
}