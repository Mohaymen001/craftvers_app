import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/product.dart';
import '../../routes/app_routes.dart';
import '../../widgets/product_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _selectedCategory = 0;
  String _sortBy = 'Popular';
  final _searchController = TextEditingController();
  String _searchQuery = '';

  List<Product> get _filteredProducts {
    var products = dummyProducts;
    if (_selectedCategory != 0) {
      final catName = dummyCategories[_selectedCategory].name;
      products = products.where((p) => p.category == catName).toList();
    }
    if (_searchQuery.isNotEmpty) {
      products = products.where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    if (_sortBy == 'Price: Low') {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'Price: High') {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'Rating') {
      products.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Catalog'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            onSelected: (value) => setState(() => _sortBy = value),
            itemBuilder: (_) => ['Popular', 'Price: Low', 'Price: High', 'Rating']
                .map((s) => PopupMenuItem(
                      value: s,
                      child: Row(
                        children: [
                          Icon(
                            _sortBy == s ? Icons.check_circle : Icons.circle_outlined,
                            color: AppColors.accent,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(s),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, color: AppColors.textLight, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // ── Category Chips ──
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: dummyCategories.length,
              itemBuilder: (context, index) {
                final cat = dummyCategories[index];
                final isSelected = _selectedCategory == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.accent : Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(cat.icon, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(
                          cat.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Results Count ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Text(
                  '${_filteredProducts.length} products found',
                  style: const TextStyle(color: AppColors.textLight, fontSize: 13),
                ),
                const Spacer(),
                Text(
                  'Sort: $_sortBy',
                  style: const TextStyle(color: AppColors.accent, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // ── Grid ──
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: AppColors.textLight),
                        SizedBox(height: 12),
                        Text(
                          'No products found',
                          style: TextStyle(color: AppColors.textLight, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: _filteredProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: _filteredProducts[index],
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.productDetails,
                          arguments: _filteredProducts[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
