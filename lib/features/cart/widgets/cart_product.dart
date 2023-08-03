import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product/services/product_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;

  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  ProductServices productServices = ProductServices();
  CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(String id) {
    cartServices.decreseProduct(context: context, id: id);
  }

  @override
  Widget build(BuildContext context) {
    final userProduct =
        Provider.of<UserProvider>(context).user.cart[widget.index];
    Product product = Product.fromMap(userProduct['product']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.h, left: 20.w),
          height: 170.h,
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  product.images.first,
                  height: 160.h,
                  width: 160.w,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 20.h),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            '\$${product.price}',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Eligible for FREE Shipping',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'In Stock',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.teal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  decreaseQuantity(userProduct['_id'].toString());
                },
                child: Container(
                  height: 32.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                  child: const Icon(Icons.remove),
                ),
              ),
              Container(
                height: 32.h,
                width: 35.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
                child: Text(
                  userProduct['quantity'].toString(),
                ),
              ),
              InkWell(
                onTap: () {
                  increaseQuantity(product);
                },
                child: Container(
                  height: 32.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
