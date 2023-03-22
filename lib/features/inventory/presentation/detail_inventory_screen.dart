import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_project/core/theme/color.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/features/inventory/data/model/inventory.dart';
import 'package:inventory_project/features/inventory/presentation/add_edit_inventory_screen.dart';
import 'package:inventory_project/features/inventory/presentation/full_view_image_screen.dart';

class DetailInventoryScreen extends StatefulWidget {
  DetailInventoryScreen({super.key, required this.docId});

  final String docId;

  @override
  State<DetailInventoryScreen> createState() => _DetailInventoryScreenState();
}

class _DetailInventoryScreenState extends State<DetailInventoryScreen> {
  Inventory? inventory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditInventoryScreen(
                            docId: widget.docId, inventory: inventory),
                      ));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: ListView(
          children: [
            inventory?.imageUrl != ''
                ? GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullViewImageScreen(
                              imageUrl: inventory!.imageUrl),
                        )),
                    child: Image.network(
                      'https://www.sony.co.id/image/cb8344f973d48449a0527a2df5661cb5?fmt=pjpeg&wid=1200&hei=470&bgcolor=F1F5F9&bgc=F1F5F9',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[400],
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
            Container(
              padding: const EdgeInsets.all(20),
              color: AppColor.bgSecondary,
              child: Text(
                inventory?.title ?? 'title',
                style: AppTypography.headline
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dataStats('Updated at', 'tgl'),
                  const SizedBox(height: 12),
                  const Divider(color: AppColor.primary),
                  const SizedBox(height: 12),
                  _dataStats('Quantity', inventory?.quantity ?? 'Quantity'),
                  const SizedBox(height: 12),
                  const Divider(color: AppColor.primary),
                  const SizedBox(height: 12),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                                child: _dataStats('Price',
                                    "Rp.${inventory?.price ?? 'Price'}"))),
                        const VerticalDivider(color: AppColor.primary),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                                // color: Colors.blue,
                                child: _dataStats('Total value',
                                    "Rp.${inventory?.totalPrice ?? 'Total price'}"))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppColor.primary),
                  _dataStats(
                      'Note',
                      inventory == null
                          ? '-'
                          : inventory!.note.isEmpty
                              ? '-'
                              : inventory?.note ?? '-')
                ],
              ),
            ),
          ],
        ));
  }

  Widget _dataStats(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTypography.regular12
              .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        Text(value, style: AppTypography.regular12),
      ],
    );
  }
}
