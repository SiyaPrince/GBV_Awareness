import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gbv_awareness/common/models/testimonials.dart';

import '../models/product.dart';
import '../models/faq_item.dart';
import 'product_services.dart';

class FirebaseProductService implements ProductService {
  FirebaseProductService._internal();
  static final FirebaseProductService instance =
      FirebaseProductService._internal();
  factory FirebaseProductService() => instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _productsRef =>
      _firestore.collection('products');

  CollectionReference<Map<String, dynamic>> get _faqRef =>
      _firestore.collection('faqItems');

  CollectionReference<Map<String, dynamic>> get _testimonialsRef =>
      _firestore.collection('testimonials');

  @override
  Stream<List<Product>> streamProducts() {
    return _productsRef
        .orderBy('order')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Stream<Product?> streamFeaturedProduct() {
    return _productsRef
        .where('isFeatured', isEqualTo: true)
        .orderBy('order')
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final doc = snapshot.docs.first;
      return Product.fromMap(doc.id, doc.data());
    });
  }

  @override
  Stream<List<FaqItem>> streamFaqItems() {
    return _faqRef
        .orderBy('order')
        .snapshots()
        .map((s) => s.docs.map((d) => FaqItem.fromMap(d.id, d.data())).toList());
  }

  @override
  Stream<List<Testimonial>> streamTestimonials() {
    return _testimonialsRef.orderBy('order').snapshots().map(
        (s) => s.docs.map((d) => Testimonial.fromMap(d.id, d.data())).toList());
  }
}
