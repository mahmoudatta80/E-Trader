import 'package:e_commerce_app/cart_model.dart';
import 'package:e_commerce_app/favourites_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? database;

  Future<Database?> createDataBase() async{
    if(database != null) {
      return database;
    }else {
      String path = join(await getDatabasesPath(),'e-commerce.db');
      Database? database = await openDatabase(
        path,
        version: 1,
        onCreate: (db,v) {
          db.execute('CREATE TABLE cart(id INTEGER, name TEXT, image TEXT, description TEXT, price REAL,count INTEGER)');
          db.execute('CREATE TABLE favourites (id INTEGER, name TEXT, image TEXT, description TEXT, price REAL)');
        }
      );
      return database;
    }
  }

  //cart database

  Future<int> insertToCart(CartModel cartModel) async{
    Database? database = await createDataBase();
    return database!.insert('cart', cartModel.toMap());
  }

  Future<List> readAllCart() async{
    Database? database = await createDataBase();
    return database!.query('cart');
  }

  Future<int> deleteFromCart(int id) async{
    Database? database = await createDataBase();
    return database!.delete('cart',where: 'id = ?',whereArgs: [id]);
  }

  Future<int> updateCart(int id , CartModel cartModel) async{
    Database? database = await createDataBase();
    return database!.update('cart', cartModel.toMap() , where: 'id = ?' , whereArgs: [id]);
  }

  //favourites database

  Future<int> insertToFavourites(FavouritesModel favouritesModel) async{
    Database? database = await createDataBase();
    return database!.insert('favourites', favouritesModel.toMap());
  }

  Future<List> readAllFavourites() async{
    Database? database = await createDataBase();
    return database!.query('favourites');
  }

  Future<int> deleteFromFavourites(int id) async{
    Database? database = await createDataBase();
    return database!.delete('favourites',where: 'id = ?',whereArgs: [id]);
  }
}