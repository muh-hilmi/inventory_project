import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inventory_project/core/theme/color.dart';
import 'package:inventory_project/core/theme/typo.dart';
import 'package:inventory_project/core/widget/loading_dialog.dart';
import 'package:inventory_project/features/inventory/data/model/inventory.dart';

import '../data/firebase_storage_service.dart';
import '../data/inventory_services.dart';

class AddEditInventoryScreen extends StatefulWidget {
  AddEditInventoryScreen({super.key, this.docId, this.inventory});

  String? docId;
  Inventory? inventory;

  @override
  State<AddEditInventoryScreen> createState() => _AddEditInventoryScreenState();
}

class _AddEditInventoryScreenState extends State<AddEditInventoryScreen> {
  late TextEditingController _titleController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late TextEditingController _noteController;

  var totalPrice = '-';

  File? imageFile;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    var title = '';
    var quantity = '';
    var price = '';
    var note = '';

    if (widget.inventory != null) {
      title = widget.inventory!.title;
      quantity = widget.inventory!.quantity;
      price = widget.inventory!.price;
      note = widget.inventory!.note;
      totalPrice = widget.inventory!.totalPrice;
    }

    _titleController = TextEditingController(text: title);
    _quantityController = TextEditingController(text: quantity);
    _priceController = TextEditingController(text: price);
    _noteController = TextEditingController(text: note);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close)),
        actions: [
          IconButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  LoadingDialog.showLoadingDialog(context);

                  var result = true;
                  final time = DateTime.now().toIso8601String();
                  if (widget.inventory == null) {
                    // add new data
                    // var imageUrl = await FirebaseStorageService.uploadImage(
                    //     time, imageFile!.path);
                    result = await InventoryService.addInventory(
                      Inventory(
                          title: _titleController.text,
                          quantity: _quantityController.text,
                          price: _priceController.text,
                          totalPrice: totalPrice,
                          note: _noteController.text,
                          updatedAt: time,
                          imageUrl: 'imageUrl'),
                    );

                    if (result) {
                      Navigator.pop(context);
                      _showSnackbar('Data has been added successfully');
                    } else {
                      _showSnackbar('Data failed to add');
                    }
                  } else {
                    // update new data
                    var imageUrl = '';
                    if (imageFile != null) {
                      imageUrl = await FirebaseStorageService.uploadImage(
                          time, imageFile!.path);
                    }

                    result = await InventoryService.updateInventory(
                        widget.docId!,
                        Inventory(
                            title: _titleController.text,
                            quantity: _quantityController.text,
                            price: _priceController.text,
                            totalPrice: totalPrice,
                            note: _noteController.text,
                            updatedAt: time,
                            imageUrl: imageFile != null
                                ? imageUrl
                                : widget.inventory!.imageUrl));

                    if (result) {
                      Navigator.pop(context);
                      _showSnackbar('Data has been updated successfully');
                    } else {
                      _showSnackbar('Data failed to edit');
                    }
                  }

                  LoadingDialog.dismissDialog(context);
                }
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: ListView(
        children: [
          imageFile != null
              ? Image.file(
                  File(imageFile!.path),
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : widget.inventory == null
                  ? _imagePickerContainer()
                  : widget.inventory!.imageUrl == ''
                      ? _imagePickerContainer()
                      : Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.amber,
                          child: Stack(
                            children: [
                              Image.network(
                                widget.inventory!.imageUrl,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text(
                                        'Edit image',
                                        style: AppTypography.regular12
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
          Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      color: AppColor.bgSecondary,
                      child: TextFormField(
                        controller: _titleController,
                        style: AppTypography.headline,
                        maxLines: 2,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: "Enter inventory name here",
                          hintStyle: AppTypography.headline
                              .copyWith(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field must be filled';
                          }
                          return null;
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _dataTextField(_quantityController, 'Quantity',
                            'Enter quantity here'),
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
                                      child: _dataTextField(_priceController,
                                          'Price', 'Enter price here'))),
                              const VerticalDivider(color: AppColor.primary),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total price',
                                        style: AppTypography.regular12.copyWith(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        totalPrice,
                                        style: AppTypography.regular12,
                                      ),
                                    ],
                                  ))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: AppColor.primary),
                        _dataTextField(
                            _noteController, 'Note', 'Enter note here',
                            mustFilled: false)
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: AppTypography.regular12.copyWith(color: Colors.white),
    )));
  }

  Widget _imagePickerContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: GestureDetector(
        onTap: () {},
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                  'Add image',
                  style: AppTypography.subHeading.copyWith(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dataTextField(
      TextEditingController controller, String title, String hintText,
      {bool mustFilled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.regular12.copyWith(fontWeight: FontWeight.w500),
        ),
        // SizedBox(height: 2),
        TextFormField(
          controller: controller,
          style: AppTypography.regular12,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTypography.regular12.copyWith(color: Colors.grey),
          ),
          onChanged: (value) {
            if (_quantityController.text.isNotEmpty &&
                _priceController.text.isNotEmpty) {
              final quantity = int.parse(_quantityController.text);
              final price = int.parse(_priceController.text);
              setState(() {
                totalPrice = (quantity * price).toString();
              });
            }
          },
          validator: (value) {
            if (mustFilled) {
              if (value!.isEmpty) {
                return 'this field must be filled';
              }
            }
          },
        )
      ],
    );
  }
}
