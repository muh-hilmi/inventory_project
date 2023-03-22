
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/typo.dart';
import '../data/model/inventory.dart';
import 'detail_inventory_screen.dart';
import 'widgets/inventory_card.dart';

class ListInventoryScreen extends StatelessWidget {
  const ListInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventories',
          style: AppTypography.title,
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 2,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('inventory').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final inventories = snapshot.data!.docs
                .map((inventory) =>
                    Inventory.fromQueryDocumentSnapshot(inventory))
                .toList();

            if (inventories.isNotEmpty) {
              return ListView.builder(
                // list inventory
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: inventories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailInventoryScreen(
                                    docId: snapshot.data!.docs[index].id,
                                  ))),
                      child: InventoryCard(inventory: inventories[index]));
                },
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/no_data.svg',
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No inventories',
                    style: AppTypography.regular12.copyWith(color: Colors.grey),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
