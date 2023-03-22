import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_project/features/inventory/data/model/inventory.dart';

class InventoryService {
  static Future<bool> addInventory(Inventory inventory) async {
    try {
      await FirebaseFirestore.instance
          .collection('inventory')
          .add(inventory.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateInventory(String docId, Inventory inventory) async {
    try {
      await FirebaseFirestore.instance
          .collection('inventory')
          .doc(docId)
          .update(inventory.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteInventory(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('inventory')
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
