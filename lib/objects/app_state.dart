import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:water_test_scanner/water_test_scanning.dart';

/// The state of the app, containing globally used variables and functions.
class AppState extends ChangeNotifier {
  
  FirebaseAuth auth;

  FirebaseFirestore firestore;

  FirebaseStorage storage;

  GeoFlutterFire geo = GeoFlutterFire();

  AppState(this.firestore, this.auth, this.storage);

  Future<void> addStrip(ColorDetectionResult result, Position loc,
      String waterType, DateTime timestamp, FirebaseFirestore firestore) async {
    var record = firestore.collection("testInstances");
    final imageLink = await uploadImage(result.imFile);
    record.doc().set(result.toFirebaseRecord(
      imageLink,
      geo.point(latitude: loc.latitude, longitude: loc.longitude).data,
      waterType,
      timestamp));
  }

  Future<String> uploadImage(File imFile) async {
    final id = const Uuid().v1();
    final storageRef = storage.ref();
    final imageRef = storageRef.child(id);
    try {
      await imageRef.putFile(imFile);
    } on FirebaseException catch (_) {
      // ...
    }
    return await imageRef.getDownloadURL();
  }
}