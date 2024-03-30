import 'package:fav_flutter/model/data_model.dart';
import 'package:fav_flutter/repository/data_load_repository.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  final String category;
  const DataScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final repository = DataLoadRepository();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('내 즐겨찾기 Data'),
        ),
        body: FutureBuilder<List<DataModel>>(
            future: repository.getCategories(category: category),
            builder: (context, snapshots) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final DataModel model = snapshots.data![index];
                        return ListTile(
                          onTap: () async {
                            // final dataRepository = DataLoadRepository();
                            // dataRepository
                            //     .getCategories(category: model.name)
                            //     .then((value) => print(value));
                          },
                          title: Text('[${model.name}], ${model.url}'),
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
