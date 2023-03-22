import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/features/inventory/data/model/inventory.dart';

class InventorySummaryCard extends StatelessWidget {
  const InventorySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.15))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.inventory, size: 16),
          const SizedBox(height: 8),
          Text(
            'Inventory Summary',
            style:
                AppTypography.regular12.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _summaryStats("Items", '12'),
              _summaryStats("Total Qty", '12'),
              _summaryStats("Total Value", '12'),
            ],
          )
        ],
      ),
    );
  }

  String _getTotalQuantity(List<Inventory> inventories) {
    var totalQty = 0;

    for (var inventory in inventories) {
      totalQty += int.parse(inventory.quantity);
    }

    return totalQty.toString();
  }

  String _getTotalValue(List<Inventory> inventories) {
    var totalValue = 0.0;

    for (var inventory in inventories) {
      totalValue += int.parse(inventory.totalPrice);
    }

    if (totalValue >= 1000000) {
      totalValue = totalValue / 1000000;
      return 'Rp.${totalValue}M';
    } else {
      totalValue = totalValue / 1000;
      return 'Rp.${totalValue}k';
    }
  }

  Widget _summaryStats(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTypography.regular12.copyWith(color: Colors.grey),
        ),
        Text(value, style: AppTypography.regular12),
      ],
    );
  }
}
