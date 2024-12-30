// ignore_for_file: file_names

import 'package:mongo_dart/mongo_dart.dart' as mongo;

class APIService {
  static const String baseUrl = 'mongodb://localhost:27017/';

  static Future<Map<String, dynamic>> insertData(
      String email, Map<String, dynamic> data, String collectionName) async {
    String dbName = email.replaceAll('@gmail.com', '');

    try {
      var db = mongo.Db('$baseUrl$dbName');
      await _retryDbOpen(db);

      var collection = db.collection(collectionName);
      var result = await collection.insertOne(data);
      await db.close();

      if (result.isSuccess) {
        return {'success': true, 'message': 'Data inserted successfully'};
      } else {
        return {'success': false, 'message': 'Failed to insert data'};
      }
    } catch (e) {
      throw Exception('Failed to insert data: $e');
    }
  }

  static Future<List<dynamic>> fetchData(
      String email, String collectionName) async {
    String dbName = email.replaceAll('@gmail.com', '');
    try {
      var db = mongo.Db('$baseUrl$dbName');
      await _retryDbOpen(db);

      var collection = db.collection(collectionName);
      var data = await collection.find().toList();
      await db.close();
      return data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<Map<String, dynamic>?> fetchOneData(
      String email, String collectionName, String field, dynamic value) async {
    String dbName = email.replaceAll('@gmail.com', '');

    try {
      var db = mongo.Db('$baseUrl$dbName');
      await _retryDbOpen(db);

      var collection = db.collection(collectionName);
      var data = await collection.findOne(
        mongo.where.eq(field, value).sortBy('_id', descending: true),
      );
      await db.close();
      return data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<Map<String, dynamic>> updateData(
      String email,
      String collectionName,
      String id,
      Map<String, dynamic> updatedData) async {
    String dbName = email.replaceAll('@gmail.com', '');

    try {
      var db = mongo.Db('$baseUrl$dbName');
      await _retryDbOpen(db);

      var collection = db.collection(collectionName);
      var modifier = mongo.modify;

      updatedData.forEach((key, value) {
        modifier = modifier.set(key, value);
      });

      var result = await collection.updateOne(
        mongo.where.id(mongo.ObjectId.parse(id)),
        modifier,
      );

      await db.close();

      if (result.isSuccess) {
        return {'success': true, 'message': 'Data updated successfully'};
      } else {
        return {'success': false, 'message': 'Failed to update data'};
      }
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  static Future<Map<String, dynamic>> deleteData(
      String email, String collectionName, String id) async {
    String dbName = email.replaceAll('@gmail.com', '');

    try {
      var db = mongo.Db('$baseUrl$dbName');
      await _retryDbOpen(db);

      var collection = db.collection(collectionName);
      var result = await collection.remove(
        mongo.where.id(
          mongo.ObjectId.parse(id),
        ),
      );

      await db.close();

      if (result['n'] > 0) {
        return {'success': true, 'message': 'Data deleted successfully'};
      } else {
        return {'success': false, 'message': 'Failed to delete data'};
      }
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  static Future<void> _retryDbOpen(mongo.Db db, {int retries = 3}) async {
    int attempt = 0;
    while (attempt < retries) {
      try {
        await db.open();
        return;
      } catch (e) {
        attempt++;
        if (attempt == retries) {
          throw Exception(
              'Failed to connect to MongoDB after $attempt retries: $e');
        }
        await Future.delayed(
          const Duration(microseconds: 1),
        );
      }
    }
  }
}
