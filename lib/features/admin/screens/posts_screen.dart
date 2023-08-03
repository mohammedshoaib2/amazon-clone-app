import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  AdminServices adminServices = AdminServices();
  List<Product>? listOfProducts;

  void navigateToAddProduct() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AddProduct();
    }));
  }

  void fetchProducts() async {
    listOfProducts = await adminServices.fetchAllProducts(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void removeProductFromList(int index) {
    listOfProducts!.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfProducts == null
          ? const Loader()
          : GridView.builder(
              itemCount: listOfProducts!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2, crossAxisCount: 2),
              itemBuilder: (context, index) {
                Product product = listOfProducts![index];
                return Column(
                  children: [
                    Flexible(child: SingleProduct(image: product.images.first)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await adminServices.deleteProduct(
                                  refreshScreen: () {
                                    removeProductFromList(index);
                                  },
                                  context: context,
                                  id: product.id!);
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add Products',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
