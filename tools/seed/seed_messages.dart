// tools/seed/seed_messages.dart
//
// Seed script for inserting example messages into Firestore for development/testing.
//
// Run with:
// flutter run -t tools/seed/seed_messages.dart
//
// Or with Dart (if configured):
// dart run tools/seed/seed_messages.dart

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Replace `your_app_name` with your actual package name
import 'package:gbv_awareness/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  const messagesPath = 'assets/seed/messages.json';

  print('Loading example messages from $messagesPath ...');
  final messages = await _loadMessagesFromAssets(messagesPath);

  print(
    'Seeding "messages" collection with ${messages.length} example items...',
  );
  await _seedMessagesCollection(firestore, messages);

  print('✅ Messages seeding completed.');
}

Future<List<MessageSeed>> _loadMessagesFromAssets(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);

  final dynamic decoded = jsonDecode(jsonString);
  if (decoded is! List) {
    throw Exception('Seed file must contain a JSON array: $assetPath');
  }

  return decoded
      .map<MessageSeed>(
        (item) => MessageSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<void> _seedMessagesCollection(
  FirebaseFirestore firestore,
  List<MessageSeed> items,
) async {
  for (final message in items) {
    final docRef = firestore.collection('messages').doc(message.id);

    // Optional: skip duplicates on re-run
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[messages] Skipping existing example message: ${message.id}');
      continue;
    }

    await docRef.set(message.toMap());
    print(
      '[messages] Seeded example message: ${message.id} (${message.email})',
    );
  }
}

class MessageSeed {
  final String id;
  final String name;
  final String email;
  final String message;
  final DateTime timestamp;

  MessageSeed({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.timestamp,
  });

  factory MessageSeed.fromJson(Map<String, dynamic> json) {
    final timestampRaw = json['timestamp'] as String?;
    if (timestampRaw == null) {
      throw Exception('Missing "timestamp" for id: ${json['id']}');
    }

    return MessageSeed(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(timestampRaw),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
