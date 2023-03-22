import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/typo.dart';
import '../../auth/presentation/profile_screen.dart';
import '../data/model/inventory.dart';
import 'add_edit_inventory_screen.dart';
import 'detail_inventory_screen.dart';
import 'list_inventory_screen.dart';
import 'widgets/inventory_summary_card.dart';
import 'widgets/inventory_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Dashboard',
            style: AppTypography.title,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ))
          ],
        ),
        backgroundColor: AppColor.bgLight,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditInventoryScreen(),
                ));
          },
          backgroundColor: AppColor.primary,
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Stack(
            children: [
              ListView(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  const InventorySummaryCard(),
                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items',
                          style: AppTypography.regular12
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: AppTypography.regular12.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.secondary),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        // list inventory
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailInventoryScreen(
                                            docId: '',
                                          ))),
                              child: InventoryCard(
                                  inventory: Inventory(
                                      title: 'camera',
                                      quantity: '12',
                                      price: '1000000',
                                      totalPrice: '12000000',
                                      note: 'note',
                                      updatedAt: '12 juni 2022',
                                      imageUrl: '')));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
