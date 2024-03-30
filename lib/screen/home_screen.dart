import 'package:fav_flutter/model/category_model.dart';
import 'package:fav_flutter/repository/category_load_repository.dart';
import 'package:fav_flutter/screen/data_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = CategoryLoadRepository();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('내 즐겨찾기'),
        ),
        body: FutureBuilder<List<CategoryModel>>(
            future: repository.getCategories(),
            builder: (context, snapshots) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final CategoryModel model = snapshots.data![index];
                        return ListTile(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DataScreen(
                                  category: model.fa_code,
                                ),
                              ),
                            );
                          },
                          title: Text(
                              '[${model.fa_code}] Title : ${model.fa_name}'),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
