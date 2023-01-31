import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (context) => ProductsProvider(null, null, []),
          update: (_, authData, previousProducts) => ProductsProvider(
              authData.token,
              authData.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(create: ((_) => Cart())),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(null, null, []),
          update: (context, authData, previousOrders) => Orders(
              authData.token,
              authData.userId,
              previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: ((context, authData, _) => MaterialApp(
              title: 'Shop App',
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato',
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                    TargetPlatform.iOS: CustomPageTransitionBuilder(),
                  })),
              home: authData.isAuth
                  ? const ProductsOverviewScreeen()
                  : FutureBuilder(
                      future: authData.tryAutoLogin(),
                      builder: ((context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? const SplashScreen()
                              : const AuthScreen())),
              routes: {
                ProductDetailScreen.routeName: (ctx) =>
                    const ProductDetailScreen(),
                CartScreen.routeName: (_) => const CartScreen(),
                OrdersScreen.routeName: (_) => const OrdersScreen(),
                UserProductsScreen.routeName: (_) => const UserProductsScreen(),
                EditProductScreen.routeName: (_) => const EditProductScreen(),
              },
            )),
      ),
    );
  }
}
