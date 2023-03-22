import 'package:flutter/material.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/features/inventory/data/model/inventory.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({super.key, required this.inventory});

  final Inventory inventory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffcccccc), width: 1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (inventory.imageUrl != '')
            Image.network(
              inventory.imageUrl,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            )
          else
            Container(
              height: 80,
              width: 80,
              color: Colors.grey[400],
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              ),
            ),
          const SizedBox(width: 14),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inventory.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.regular12
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                RichText(
                    text: TextSpan(
                        text: '${inventory.quantity} units',
                        style: AppTypography.regular12
                            .copyWith(fontWeight: FontWeight.w500),
                        children: [
                      TextSpan(
                          text: ' | Rp.${inventory.price}',
                          style: AppTypography.regular12.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.grey))
                    ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
