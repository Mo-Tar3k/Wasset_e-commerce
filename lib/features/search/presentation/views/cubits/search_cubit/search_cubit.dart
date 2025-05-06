import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/core/repos/products_repo/products_repo.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortOption { none, priceAsc, priceDesc, latest }

class SearchCubit extends Cubit<SearchState> {
  final ProductsRepo _productsRepo;

  SearchCubit(this._productsRepo) : super(SearchInitial()) {
    _loadRecentSearches();
  }

  String _query = '';
  List<String> _recentSearches = [];
  List<ProductEntity> results = [];
  List<ProductEntity> allProducts = [];

  int? minPrice;
  int? maxPrice;
  SortOption sortOption = SortOption.none;

  String get query => _query;
  List<String> get recentSearches => _recentSearches;

  // Load recent searches from SharedPreferences
  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList('recent_searches') ?? [];
    emit(SearchChanged()); // Emit change to update UI
  }

  // Save recent searches to SharedPreferences
  Future<void> _saveRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recent_searches', _recentSearches);
  }

  void updateQuery(String value) {
    _query = value;
    emit(SearchChanged());
    searchProducts(value);
  }

  void searchProducts(String value) async {
    emit(SearchLoading());
    final result = await _productsRepo.getProducts();

    result.fold((failure) => emit(SearchNoResults()), (products) {
      allProducts = products;
      results =
          products.where((product) {
            final nameMatch = product.name.toLowerCase().contains(
              value.toLowerCase(),
            );
            final priceMatch =
                (minPrice == null || product.price >= minPrice!) &&
                (maxPrice == null || product.price <= maxPrice!);
            return nameMatch && priceMatch;
          }).toList();

      applySorting();

      // إضافة الكلمة المفتاحية إلى السجلات حتى إذا لم يتم العثور على نتائج
      if (!_recentSearches.contains(value)) {
        _recentSearches.insert(0, value);
        _saveRecentSearches(); // حفظ السجلات المحدثة
      }

      if (results.isNotEmpty) {
        emit(SearchSuccess());
      } else {
        emit(SearchNoResults());
      }
    });
  }

  void updatePriceFilter({int? min, int? max}) {
    minPrice = min ?? 0;
    maxPrice = max ?? 500000;

    // تطبيق الفلتر على قائمة allProducts التي تطابق البحث الأولي
    results =
        allProducts.where((product) {
          final nameMatch = product.name.toLowerCase().contains(
            query.toLowerCase(),
          );
          final priceMatch =
              (minPrice == null || product.price >= minPrice!) &&
              (maxPrice == null || product.price <= maxPrice!);
          return nameMatch && priceMatch;
        }).toList();

    // تحديث الحالة بناءً على النتائج
    if (results.isNotEmpty) {
      emit(SearchSuccess());
    } else {
      emit(SearchNoResults());
    }
  }

  void applySortOption(SortOption option) {
    sortOption = option;
    applySorting();
    emit(SearchSuccess());
  }

  void applySorting() {
    switch (sortOption) {
      case SortOption.priceAsc:
        results.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDesc:
        results.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.latest:
        results = results.reversed.toList();
        break;
      case SortOption.none:
        break;
    }
  }

  void clearAllSearches() {
    _recentSearches.clear();
    _saveRecentSearches(); // Save cleared list
    emit(SearchChanged());
  }

  void removeSearch(String term) {
    _recentSearches.remove(term);
    _saveRecentSearches(); // Save updated list after removal
    emit(SearchChanged());
  }

  void resetSearch() {
    _query = '';
    minPrice = null;
    maxPrice = null;
    sortOption = SortOption.none;
    results.clear();
    emit(SearchChanged());
  }
}
