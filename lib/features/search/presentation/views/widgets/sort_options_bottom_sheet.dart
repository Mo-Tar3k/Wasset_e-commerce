import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortOptionsBottomSheet extends StatefulWidget {
  final BuildContext parentContext;

  const SortOptionsBottomSheet({super.key, required this.parentContext});

  @override
  State<SortOptionsBottomSheet> createState() => _SortOptionsBottomSheetState();
}

class _SortOptionsBottomSheetState extends State<SortOptionsBottomSheet> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    final cubit = widget.parentContext.read<SearchCubit>();
    selectedOption = _getOptionString(cubit.sortOption);
  }

  String _getOptionString(SortOption option) {
    switch (option) {
      case SortOption.priceAsc:
        return "asc";
      case SortOption.priceDesc:
        return "desc";
      case SortOption.latest:
        return "latest";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Sort By :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          RadioListTile<String>(
            title: const Text("Price (Low To High)"),
            value: "asc",
            groupValue: selectedOption,
            onChanged: (val) {
              setState(() => selectedOption = val);
            },
          ),
          RadioListTile<String>(
            title: const Text("Price (High To Low)"),
            value: "desc",
            groupValue: selectedOption,
            onChanged: (val) {
              setState(() => selectedOption = val);
            },
          ),
          RadioListTile<String>(
            title: const Text("Latest"),
            value: "latest",
            groupValue: selectedOption,
            onChanged: (val) {
              setState(() => selectedOption = val);
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final cubit = widget.parentContext.read<SearchCubit>();

              switch (selectedOption) {
                case "asc":
                  cubit.applySortOption(SortOption.priceAsc);
                  break;
                case "desc":
                  cubit.applySortOption(SortOption.priceDesc);
                  break;
                case "latest":
                  cubit.applySortOption(SortOption.latest);
                  break;
                default:
                  cubit.applySortOption(SortOption.none);
              }

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text("Filter"),
          ),
        ],
      ),
    );
  }
}
