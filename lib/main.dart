import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
  bool processing = true;
  void getData() async {
    await authService.getUserData(context: context);
    setState(() {
      processing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 690),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: GlobalVariables.backgroundColor,
              primaryColor: GlobalVariables.secondaryColor,
              colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor,
              ),
              appBarTheme: const AppBarTheme(
                color: GlobalVariables.secondaryColor,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              useMaterial3: false),
          home: Scaffold(
            body: processing
                ? const Center(child: CircularProgressIndicator())
                : Provider.of<UserProvider>(context).user.token.isNotEmpty
                    ? Provider.of<UserProvider>(context).user.type == 'user'
                        ? const BottomBar()
                        : const AdminScreen()
                    : const AuthScreen(),
          ),
        );
      },
    );
  }
}
