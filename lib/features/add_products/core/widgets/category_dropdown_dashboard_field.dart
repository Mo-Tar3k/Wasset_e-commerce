import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/add_products/core/services/api_service_dashboard.dart';
import 'package:flutter/material.dart';

class CategoryDropdownFieldDashboard extends StatefulWidget {
  const CategoryDropdownFieldDashboard({
    super.key,
    required this.labelText,
    this.onChanged,
    this.onSaved,
  });

  final String labelText;
  final ValueChanged<int?>? onChanged; // Updated to return category ID
  final void Function(int?)? onSaved; // Updated to save category ID

  @override
  _CategoryDropdownFieldDashboardState createState() =>
      _CategoryDropdownFieldDashboardState();
}

class _CategoryDropdownFieldDashboardState
    extends State<CategoryDropdownFieldDashboard> {
  String? selectedCategoryName;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final apiService = getIt<ApiServiceDashboard>();
      final fetchedCategories = await apiService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load categories: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
          decoration: BoxDecoration(
            color: AppColors.gray(context),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.gray(context),
            ),
            value: selectedCategoryName,
            items:
                categories
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category['categoryName'],
                        child: Text(category['categoryName']),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedCategoryName = value;
              });
              if (widget.onChanged != null) {
                final selectedCategory = categories.firstWhere(
                  (category) => category['categoryName'] == value,
                );
                widget.onChanged!(selectedCategory['id']);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            onSaved: (value) {
              if (widget.onSaved != null) {
                final selectedCategory = categories.firstWhere(
                  (category) => category['categoryName'] == value,
                );
                widget.onSaved!(selectedCategory['id']);
              }
            },
          ),
        );
  }
}
