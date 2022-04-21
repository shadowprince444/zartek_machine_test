import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine_test/controllers/menu_controller.dart';
import 'package:zartek_machine_test/controllers/profile_controller.dart';
import 'package:zartek_machine_test/controllers/sign_in_controller.dart';
import 'package:zartek_machine_test/models/hive/add_on_hive_model.dart';
import 'package:zartek_machine_test/models/hive/dish_order_hive_model.dart';
import 'package:zartek_machine_test/models/hive/order_model.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';
import 'package:zartek_machine_test/utils/size_utils/size_config.dart';
import 'package:zartek_machine_test/views/screens/home/home_screen.dart';
import 'package:zartek_machine_test/views/screens/log_in/log_in_screen.dart';
import 'package:zartek_machine_test/views/screens/profile_screen.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(DishOrderHiveModelAdapter());
  Hive.registerAdapter(AddOnHiveModelAdapter());
  await Hive.openBox<OrderModel>("carted_orders");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<SignInController>(
          create: (context) => SignInController(),
        ),
        ChangeNotifierProvider<MenuProviderController>(
          create: (context) => MenuProviderController(),
        ),
        ChangeNotifierProxyProvider<Auth, ProfileController>(
          create: (_) => ProfileController(),
          update: (context, auth, profile) => profile!..updateUserId(auth.userId),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => MenuProviderController(),
        // ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: InitialScreen(),
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final fireBaseAuth = FirebaseAuth.instance;
  late final Auth auth;
  late final ProfileController profileController;
  late Future<InitialScreenStatus> initialScreenState;
  User? user;

  @override
  void initState() {
    auth = Provider.of<Auth>(context, listen: false);
    user = fireBaseAuth.currentUser;
    if (user != null) {
      initialScreenState = userToken();
    } else {
      initialScreenState = Future.value(InitialScreenStatus.unauthenticated);
    }
    super.initState();
  }

  Future<InitialScreenStatus> userToken() async {
    String k = await user!.getIdToken();
    auth!.store(k, user!.uid);
    profileController = Provider.of<ProfileController>(context, listen: false);
    return await profileController.getUserProfile(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder<InitialScreenStatus>(
        future: initialScreenState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == InitialScreenStatus.unauthenticated) {
              return const LogInScreen();
            } else if (snapshot.data == InitialScreenStatus.authenticated) {
              return const HomeScreen();
            } else {
              return const AddProfileScreen();
            }
          } else {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildInkWell(context),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }
        });
  }

  buildInkWell(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await FirebaseAuth.instance.signOut().then(
        //       (value) => Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(builder: (context) => const LogInScreen()),
        //         (route) => false,
        //       ),
        //     );
      },
      child: SizedBox(
        height: 250.vdp(),
        child: Image.asset(
          "assets/images/firebase_logo.png",
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
