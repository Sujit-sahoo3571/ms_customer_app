import 'dart:async';

import 'package:ms_customer_app/provider/product_class.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

//const
const String CART_TABLE = "cart_items";
const String WISH_TABLE = "wish_items";

class SQLHelper {
  static Database? _database;
  static get getDatabase async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = p.join(await getDatabasesPath(), "shopping_database.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

////////////////////////////////////
////////////////////////////////////
/////////CREATE DATABASE ////////////
////////////////////////////////////
////////////////////////////////////
////////////////////////////////////
  static FutureOr<void> _onCreate(Database db, int version) {
    Batch batch = db.batch();
    batch.execute("""
CREATE TABLE $CART_TABLE (
documentid TEXT PRIMARY KEY,
name Text,
price DOUBLE,
qty INTEGER,
qntty INTEGER,
imageUrl TEXT,
suppid TEXT)
""");
    batch.execute("""
CREATE TABLE $WISH_TABLE (
documentid TEXT PRIMARY KEY,
name Text,
price DOUBLE,
qty INTEGER,
qntty INTEGER,
imageUrl TEXT,
suppid TEXT)
""");

    batch.commit();
    print("table is created");
  }

  ////////////////////////////////////
////////////////////////////////////
/////////INSERT DATABASE ////////////
////////////////////////////////////
////////////////////////////////////
////////////////////////////////////

  static Future<void> insertItem(Product product) async {
    Database db = await getDatabase;

    await db.insert(CART_TABLE, product.toMap());
    print(await db.query(CART_TABLE));
  }
  ////////////////////////////////////
////////////////////////////////////
/////////LOAD DATA FROM DATABASE ///
////////////////////////////////////
////////////////////////////////////

  static Future<List<Map>> loadCartItems() async {
    Database db = await getDatabase;
    return await db.query(CART_TABLE);
  }

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
/////////DELETE DATA FROM CART ITEM DATABASE /////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

  static Future<void> deleteItem(String id) async {
    Database db = await getDatabase;
    await db.delete(CART_TABLE, where: "documentid=?", whereArgs: [id]);
    print(await db.query(CART_TABLE));
  }
  //////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
/////////DELETE ALL CART ITEM DATABASE ///////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

  static Future<void> deleteAllItem() async {
    Database db = await getDatabase;
    await db.delete(CART_TABLE);
    print(await db.query(CART_TABLE));
  }

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
/////////UPDATE CART ITEM QUANTITY DATABASE //////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

  static Future<void> updateItemqty(Product newProduct, int x) async {
    Database db = await getDatabase;
    await db.update(CART_TABLE, {"qty": (newProduct.qty + x)},
        where: "documentid = ?", whereArgs: [newProduct.documentid]);
    print(await db.query(CART_TABLE));
  }

// Wishlist Table

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
/////////INSERT WISHLIST ITEM IN DATABASE //////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

  static Future<void> insertWishList(Product product) async {
    Database db = await getDatabase;
    await db.insert(WISH_TABLE, product.toMap());

    print(await db.query(WISH_TABLE));
  }

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
/////////Load WISHLIST ITEM From DATABASE //////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
  static Future<List<Map>> loadWishList() async {
    Database db = await getDatabase;
    return await db.query(WISH_TABLE);
  }

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
/////////REMOVE WISHLIST ITEM FROM DATABASE //////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

  static Future<void> removeWishListItem(Product product) async {
    Database db = await getDatabase;
    await db.delete(WISH_TABLE,
        where: "documentid = ?", whereArgs: [product.documentid]);
    // print(await db.query(WISH_TABLE));
  }

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
/////////REMOVE WISHLIST ITEM FROM DATABASE //////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

  static Future<void> removeAllWishList() async {
    Database db = await getDatabase;
    await db.delete(WISH_TABLE);
  }
}
