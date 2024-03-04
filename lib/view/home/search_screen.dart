import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/search_user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/component/buttonCustom.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Screen')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: 'Search user', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              SubmitButton(
                buttonLabel: 'Search',
                textCol: AppColors.black,
                he: MediaQuery.of(context).size.height * 0.05,
                col: AppColors.theme,
                wi: MediaQuery.of(context).size.width * 0.4,
                submitFuction: () {
                  setState(() {});
                  searchElement();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              searchElement(),
            ],
          ),
        ),
      ),
    );
  }

  dynamic searchElement() {
    return FutureBuilder(
      future: AuthViewModel().searchuser(
        searchController.text == '' ? "" : searchController.text,
        context,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            final queryData = snapshot.data;
            final userData = Search_user_Model.fromJson(queryData);

            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: userData.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.profile,arguments: {
                        'userid':userData.data![index].sId,
                      });
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(userData.data![index].profilePicUrl!),
                    ),
                    title: Text(userData.data![index].name!),
                    subtitle: Text(userData.data![index].userName!),
                  );
                });
          } else {
            return const Text('No data');
          }
        }
      },
    );
  }
}
