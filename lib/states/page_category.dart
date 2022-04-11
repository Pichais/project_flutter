import 'package:flutter/material.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/utillity/product_model.dart';

class PageCategory extends StatefulWidget {
  const PageCategory({Key? key}) : super(key: key);

  @override
  State<PageCategory> createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory> {
  ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Myconstant.primary,
        title: Text('Page_Categories'),
      ),
      body: SafeArea(
        child: ListView(
          children: [Text('----Welcome----')],
        ),
      ),
    );
  }
}
