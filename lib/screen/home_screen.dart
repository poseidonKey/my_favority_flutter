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
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * .07),
          child: AppBar(
            title: const Text(
              '[My Internet Favorites!! 😀]',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurpleAccent),
            ),
          ),
        ),
        body: FutureBuilder<List<CategoryModel>>(
            future: repository.getCategories(),
            builder: (context, snapshots) {
              if (!snapshots.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  const PreferredSize(
                    preferredSize:
                        Size.fromHeight(2.0), // Height of the Divider
                    child: Divider(
                      color: Colors.red,
                      thickness: 2.0,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: snapshots.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshots.hasError) {
                          return const Center(
                            child: Text('즐겨 찾기 정보를 가져오지 못했습니다.'),
                          );
                        }

                        // 로딩 중일 때 보여줄 화면
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }
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
                            '[${model.fa_code}] Category Title : ${model.fa_name}',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 5,
                        child: Container(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
