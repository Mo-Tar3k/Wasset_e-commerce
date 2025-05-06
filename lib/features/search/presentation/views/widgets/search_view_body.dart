import 'package:e_commerce/core/widgets/search_text_field.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_cubit.dart';
import 'package:e_commerce/features/search/presentation/views/widgets/search_result_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<SearchCubit>().resetSearch();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const SearchTextField(),
            ),
            Expanded(child: SearchResultBuilder()),
          ],
        ),
      ),
    );
  }
}
