import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final bool isNew;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.reviewCount,
    this.images = const [],
    this.isNew = false,
    this.isFavorite = false,
  });
}

class Category {
  final String id;
  final String name;
  final String icon;
  final Color? color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    this.color,
  });
}

// ── Dummy Data ──────────────────────────────────────────────

final List<Category> dummyCategories = [
  Category(id: '1', name: 'All', icon: '🛍️', color: const Color(0xFFE94560)),
  Category(id: '2', name: 'Hot Coffee', icon: '☕', color: const Color(0xFF4A90E2)),
  Category(id: '3', name: 'Iced Coffee', icon: '🧊', color: const Color(0xFFE91E8C)),
  Category(id: '4', name: 'Espresso', icon: '🥤', color: const Color(0xFF50C878)),
  Category(id: '5', name: 'Desserts', icon: '🍰', color: const Color(0xFFF5A623)),
  Category(id: '6', name: 'Coffee Beans', icon: '🫘', color: const Color(0xFF9B59B6)),
];

final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Cappuccino',
    description: 'A rich cappuccino topped with creamy foam, served in a cozy café setting with warm tones and a smooth texture.',
    price: 299.99,
    oldPrice: 399.99,
    imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500',
    category: 'Hot Coffee',
    rating: 4.8,
    reviewCount: 1240,
    isNew: true,
    images: [
      'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500',
      'https://images.unsplash.com/photo-1498804103079-a6351b050096?w=500',
    ],
  ),
  Product(
    id: '2',
    name: 'Latte',
    description: 'A smooth latte with delicate milk art, served in a stylish cup with a calm café atmosphere and soft lighting.',
    price: 189.00,
    imageUrl: 'https://images.unsplash.com/photo-1470337458703-46ad1756a187?w=500',
    category: 'Hot',
    rating: 4.6,
    reviewCount: 856,
    images: [
      'https://images.unsplash.com/photo-1470337458703-46ad1756a187?w=500',
      'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500',
    ],
  ),
  Product(
    id: '3',
    name: 'Pour Over Coffee',
    description: 'Freshly brewed pour-over coffee dripping into a glass server, highlighting a minimal and modern coffee brewing setup.',
    price: 129.99,
    oldPrice: 159.99,
    imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500',
    category: 'Coffee',
    rating: 4.5,
    reviewCount: 2100,
    isNew: true,
    images: [
      'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500',
    ],
  ),
  Product(
    id: '4',
    name: 'Breakfast Coffee',
    description: 'A perfect morning coffee served alongside a delicious breakfast, creating a warm and inviting café vibe.',
    price: 119.00,
    oldPrice: 145.00,
    imageUrl: 'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?w=500',
    category: 'Coffee',
    rating: 4.7,
    reviewCount: 3400,
    images: [
      'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?w=500',
      'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=500',
    ],
  ),
  Product(
    id: '5',
    name: 'Coffee Beans',
    description: 'Premium roasted coffee beans captured in a rustic café setting, showcasing rich texture and deep brown tones.',
    price: 245.00,
    imageUrl: 'https://images.unsplash.com/photo-1521017432531-fbd92d768814?w=500',
    category: 'Coffee',
    rating: 4.9,
    reviewCount: 678,
    images: [
      'https://images.unsplash.com/photo-1521017432531-fbd92d768814?w=500',
    ],
  ),
  Product(
    id: '6',
    name: 'Espresso',
    description: 'A bold espresso shot in a small cup, delivering strong flavor and a classic coffeehouse experience.',
    price: 68.00,
    imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=500',
    category: 'Home',
    rating: 4.4,
    reviewCount: 312,
    isNew: true,
    images: [
      'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=500',
    ],
  ),
];