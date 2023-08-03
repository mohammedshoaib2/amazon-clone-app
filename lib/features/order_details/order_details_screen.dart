import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  final Order order;

  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 0;
  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  AdminServices adminServices = AdminServices();

  void updateStatus(int status) {
    adminServices.updateStatus(
        context: context,
        onSuccess: () {
          setState(() {
            currentStep++;
          });
        },
        order: widget.order,
        status: status + 1);
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View Order Details',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 2.w, color: Colors.black26)),
                child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date : ${DateFormat().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.order.orderedAt),
                        )}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Order ID :  ${widget.order.id}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Order Total :  \$${widget.order.totalPrice}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Purchase Details',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 150.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.order.productDetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 20.w),
                      height: 150.h,
                      width: MediaQuery.of(context).size.width - 30.r,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.w,
                          color: Colors.black26,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 150.h,
                            width: 150.h,
                            child: Image.network(
                                widget.order.productDetails[0].images.first),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.order.productDetails[index].name,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('Qty : ${widget.order.quantity[index]}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Tracking',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.w,
                    color: Colors.black26,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (Provider.of<UserProvider>(context).user.type ==
                            'admin' &&
                        details.currentStep < 3) {
                      return CustomButton(
                          onTap: () {
                            updateStatus(details.currentStep);
                          },
                          text: 'Done');
                    }
                    return const Text('');
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text('Your Order is yet to be delivered'),
                      isActive: currentStep >= 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                          'Your Order has been delivered, you are yet sign'),
                      isActive: currentStep >= 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                          'Your Order has been delivered and signed by you'),
                      isActive: currentStep >= 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text('Your Order is yet to be delivered'),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
