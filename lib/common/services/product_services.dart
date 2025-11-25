import 'package:gbv_awareness/common/models/testimonials.dart';

import '../models/product.dart';
import '../models/faq_item.dart';

abstract class ProductService {
  /// All products ordered by 'order' field.
  Stream<List<Product>> streamProducts();

  /// First product where isFeatured == true (or null if none).
  Stream<Product?> streamFeaturedProduct();

  /// All FAQ items ordered by 'order'.
  Stream<List<FaqItem>> streamFaqItems();

  /// All testimonials ordered by 'order'.
  Stream<List<Testimonial>> streamTestimonials();
}
