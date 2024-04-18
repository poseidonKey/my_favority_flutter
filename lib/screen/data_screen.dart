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
              if (!snapshots.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshots.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshots.hasError) {
                          return const Center(
                            child: Text('즐겨 찾기 세부 정보를 가져오지 못했습니다.'),
                          );
                        }
                        // 로딩 중일 때 보여줄 화면
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }
                        final DataModel model = snapshots.data![index];
                        return Dismissible(
                          key: ObjectKey(model.no),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) async {
                            final result =
                                await repository.deleteData(no: model.no);
                            if (result == 'delete Data') {
                              print('success');
                            } else {
                              print('error');
                            }
                          },
                          child: ListTile(
                            onTap: () async {
                              showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .95,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 80,
                                          ),
                                          const Center(
                                            child: Text(
                                              'Data 정보',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'subject : ${model.name}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'URL - ${model.url}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'etc : ${model.alt}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('close')),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                              // final dataRepository = DataLoadRepository();
                              // dataRepository
                              //     .getCategories(category: model.name)
                              //     .then((value) => print(value));
                            },
                            title: Text(
                              '[${model.name}] - ${model.url}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close')),
                  )
                ],
              );
            }),
      ),
    );
  }
}
