import 'package:flutter/material.dart';

class SupportResource {
  final String id;
  final String name;
  final String type;
  final String contact;
  final String region;
  final String hours;
  final String description;
  final bool isEmergency;
  final String url;

  const SupportResource({
    required this.id,
    required this.name,
    required this.type,
    required this.contact,
    required this.region,
    required this.hours,
    required this.description,
    required this.isEmergency,
    required this.url,
  });

  String get displayType {
    switch (type) {
      case 'hotline':
        return '24/7 Emergency Hotline';
      case 'shelter':
        return 'Safe Shelter';
      case 'legal':
        return 'Legal Support';
      case 'health':
        return 'Health Services';
      case 'organization':
        return 'Support Organization';
      default:
        return type;
    }
  }

  IconData get icon {
    switch (type) {
      case 'hotline':
        return Icons.phone;
      case 'shelter':
        return Icons.home;
      case 'legal':
        return Icons.gavel;
      case 'health':
        return Icons.local_hospital;
      case 'organization':
        return Icons.people;
      default:
        return Icons.help;
    }
  }

  Color get color {
    switch (type) {
      case 'hotline':
        return Colors.red;
      case 'shelter':
        return Colors.orange;
      case 'legal':
        return Colors.blue;
      case 'health':
        return Colors.green;
      case 'organization':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  bool get hasContact => contact.isNotEmpty;
  bool get hasWebsite => url.isNotEmpty;

  factory SupportResource.fromFirestore(Map<String, dynamic> data, String id) {
    return SupportResource(
      id: id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      contact: data['contact'] ?? '',
      region: data['region'] ?? '',
      hours: data['hours'] ?? '',
      description: data['description'] ?? '',
      isEmergency: data['isEmergency'] ?? false,
      url: data['url'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'type': type,
      'contact': contact,
      'region': region,
      'hours': hours,
      'description': description,
      'isEmergency': isEmergency,
      'url': url,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportResource &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
