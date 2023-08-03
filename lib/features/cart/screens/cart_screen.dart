import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  height: 42.h,
                  margin: EdgeInsets.only(left: 15.w),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(7.r),
                    child: TextFormField(
                      onFieldSubmitted: (search) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SearchScreen(searchQueary: search);
                            },
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: true,
                        hintText: 'Search in Amazon.in',
                        fillColor: GlobalVariables.backgroundColor,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Colors.black12),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.r))),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              const Icon(
                Icons.mic,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          const AddressBox(),
          const CartSubtotal(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: CustomButton(
              text: user.cart.isNotEmpty
                  ? 'Proceed to Buy (${user.cart.length} items)'
                  : 'Add Products to Continue',
              onTap: () {
                if (user.cart.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const AddressScreen();
                  }));
                }
              },
              color: user.cart.isNotEmpty ? Colors.yellow[600] : Colors.black12,
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.black12.withOpacity(0.08),
          ),
          SizedBox(
            height: 20.h,
          ),
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              }),
        ],
      ),
    );
  }
}
