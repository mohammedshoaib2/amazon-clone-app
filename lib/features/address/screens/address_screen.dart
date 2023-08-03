import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  final _addressKey = GlobalKey<FormState>();

  final AddressServices addressServices = AddressServices();

  String addressToBeUsed = "";
  bool isPayPressed = false;

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  List<PaymentItem> paymentItem = [];

  void onPaymentResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {}
  }

  void onPayPressed(String address) {
    addressToBeUsed = "";
    bool isFormChanged = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFormChanged) {
      if (_addressKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('please enter all values');
      }
    } else if (address.isNotEmpty) {
      addressToBeUsed = address;
    } else {
      showSnackbar(context: context, text: 'address is empty');
      throw Exception('Error');
    }
  }

  void placeOrder(double totalPrice, String address) {
    addressServices.placeOrder(
        context: context, totalPrice: totalPrice, address: address);
  }

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;
    final user = Provider.of<UserProvider>(context).user;
    double total = 0;
    for (var cart in user.cart) {
      int price = cart['product']['price'];
      int quantitiy = cart['quantity'];
      total = total + (price * quantitiy);
    }
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: Column(
              children: [
                address.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.h),
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 1,
                              color: Colors.black12,
                            )),
                            child: Text(
                              address,
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'OR',
                            style: TextStyle(fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      )
                    : const Text(''),
                Form(
                    key: _addressKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                            hint: 'Flat, House no, Building',
                            controller: flatBuildingController),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextFormField(
                            hint: 'Area, Street', controller: areaController),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextFormField(
                            hint: 'Pincode', controller: pincodeController),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextFormField(
                            hint: 'Town/City', controller: cityController),
                        SizedBox(
                          height: 20.h,
                        ),
                        FutureBuilder(
                            future: _googlePayConfigFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GooglePayButton(
                                  width: double.infinity,
                                  onPaymentResult: onPaymentResult,
                                  type: GooglePayButtonType.buy,
                                  paymentConfiguration: snapshot.data,
                                  onPressed: () {
                                    onPayPressed(address);
                                  },
                                  onError: (error) {
                                    showSnackbar(
                                        context: context,
                                        text: error.toString());
                                  },
                                  loadingIndicator: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  paymentItems: paymentItem,
                                );
                              }
                              return const Text('');
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                            text: 'Save Address',
                            color: Colors.black12,
                            onTap: () {
                              if (addressToBeUsed.isNotEmpty) {
                                addressServices.addAddress(
                                    context: context, address: addressToBeUsed);
                              }
                            }),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                            text: 'Place Order',
                            onTap: () {
                              placeOrder(total, address);
                            }),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
