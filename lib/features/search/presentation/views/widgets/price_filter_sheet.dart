import 'dart:async'; // For Timer and debounce
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceFilterSheet extends StatefulWidget {
  final BuildContext parentContext;
  const PriceFilterSheet({super.key, required this.parentContext});

  @override
  State<PriceFilterSheet> createState() => _PriceFilterSheetState();
}

class _PriceFilterSheetState extends State<PriceFilterSheet> {
  int _minPrice = 0;
  int _maxPrice = 500000;

  late TextEditingController _minController;
  late TextEditingController _maxController;

  final int _sliderMin = 0;
  final int _sliderMax = 500000;

  Timer? _debounce; // To debounce search input

  @override
  void initState() {
    super.initState();

    // // إعادة تعيين حالة البحث عند فتح الشاشة
    // widget.parentContext.read<SearchCubit>().resetSearch();

    final cubit = widget.parentContext.read<SearchCubit>();

    // تعيين القيم المحفوظة من SearchCubit
    _minPrice = cubit.minPrice?.toInt() ?? _sliderMin;
    _maxPrice = cubit.maxPrice?.toInt() ?? _sliderMax;

    // تعيين القيم إلى TextEditingController
    _minController = TextEditingController(text: _minPrice.toString());
    _maxController = TextEditingController(text: _maxPrice.toString());
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    _debounce?.cancel(); // Cancel debounce when disposing
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1200), () {
      if (value.isNotEmpty) {
        print('Searching for: $value');
        // Do something with the search term
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom; // For keyboard height

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: bottomInset > 0 ? bottomInset + 16 : 24,
        ),
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 50,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color:
                    isDarkMode(context) ? AppColors.lightMode : Colors.black45,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Filter by:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.price_change_outlined),
              ],
            ),
            const SizedBox(height: 16),
            RangeSlider(
              activeColor: AppColors.primaryColor,
              inactiveColor: Colors.grey[300],
              values: RangeValues(_minPrice.toDouble(), _maxPrice.toDouble()),
              min: _sliderMin.toDouble(),
              max: _sliderMax.toDouble(),
              divisions: 100,
              labels: RangeLabels('${_minPrice}', '${_maxPrice}'),
              onChanged: (values) {
                setState(() {
                  _minPrice = values.start.toInt().clamp(
                    _sliderMin,
                    _sliderMax,
                  );
                  _maxPrice = values.end.toInt().clamp(_sliderMin, _sliderMax);
                  _minController.text = _minPrice.toString();
                  _maxController.text = _maxPrice.toString();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Min'),
                    onChanged: (value) {
                      _onSearchChanged(value);
                      final parsedValue = int.tryParse(value);
                      if (parsedValue != null) {
                        setState(() {
                          _minPrice = parsedValue.clamp(_sliderMin, _sliderMax);
                          _minController.text = _minPrice.toString();
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _maxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Max'),
                    onChanged: (value) {
                      _onSearchChanged(value);
                      final parsedValue = int.tryParse(value);
                      if (parsedValue != null) {
                        setState(() {
                          _maxPrice = parsedValue.clamp(_sliderMin, _sliderMax);
                          _maxController.text = _maxPrice.toString();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: CustomButton(
                onPressed: () {
                  final int? min = int.tryParse(_minController.text);
                  final int? max = int.tryParse(_maxController.text);

                  // تطبيق الفلتر فقط على النتائج الحالية
                  widget.parentContext.read<SearchCubit>().updatePriceFilter(
                    min: min,
                    max: max,
                  );

                  Navigator.pop(context);
                },
                text: 'Apply Filter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
