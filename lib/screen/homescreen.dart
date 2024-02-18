import 'package:cached_network_image/cached_network_image.dart';
import 'package:codewithdheeraj/provider/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoViewProvider _todoViewProvider = TodoViewProvider();

  @override
  void initState() {
    _todoViewProvider = Provider.of<TodoViewProvider>(context, listen: false);
    getalldata();
    super.initState();
  }

  getalldata() async {
    await _todoViewProvider.getTodoResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoViewProvider>(
        builder: (context, todoViewProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text("Product List Using Rest API And Provider")),
        ),
        body: (todoViewProvider.isLoading)
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: todoViewProvider.todoModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1, // this is the ratio
                            child: CachedNetworkImage(
                              // this is to fetch the image
                              imageUrl: todoViewProvider.todoModel[index].image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          ListTile(
                            title:
                                Text(todoViewProvider.todoModel[index].title),
                            subtitle: Text(
                                '${todoViewProvider.todoModel[index].price} \$'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: Colors.orange),
                                Text(
                                    '${todoViewProvider.todoModel[index].rating.rate}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      );
    });
  }
}
