// ignore_for_file: avoid_print

import 'package:badges/badges.dart' as badges;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ms_customer_app/provider/cart_provider.dart';
import 'package:ms_customer_app/provider/wishlist_product.dart';
import 'package:ms_customer_app/screens/category_screen.dart';
import 'package:ms_customer_app/screens/customer_cart_screen.dart';
import 'package:ms_customer_app/screens/customer_profilescreen.dart';
import 'package:ms_customer_app/screens/customer_storescreen.dart';
import 'package:ms_customer_app/screens/customer_home_screen.dart';
import 'package:ms_customer_app/services/notification_services.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomerBottomNavigation extends StatefulWidget {
  int selectedIndex;
  static const customerHomeRouteName = '/customer_home';

  CustomerBottomNavigation({super.key, this.selectedIndex = 0});

  @override
  State<CustomerBottomNavigation> createState() =>
      _CustomerBottomNavigationState();
}

class _CustomerBottomNavigationState extends State<CustomerBottomNavigation> {
  final List<Widget> _tabs = [
    const CustomerHomeScreen(),
    const CategoryScreen(),
    const CustomerStoreScreen(),
    const CustomerCartScreen(),
    const CustomerProfileScreen(
        // documentId: FirebaseAuth.instance.currentUser!.uid,
        ),
  ];

  foregroundMessage() {
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print("value : $value"));
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Customer App .... Got a message whilst in the foreground!');
      print('Customer App ....  Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Customer App ....  Message also contained a notification: ${message.notification}');
        NotificationsServices.showNotification(message);
      }
    });
  }

  @override
  void initState() {
    context.read<Cart>().loadItemsProvider();
    context.read<Wish>().loadWishlist();
    foregroundMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        currentIndex: widget.selectedIndex,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          const BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Store'),
          BottomNavigationBarItem(
              icon: badges.Badge(
                  showBadge:
                      context.read<Cart>().getItems.isEmpty ? false : true,
                  padding: const EdgeInsets.all(2.0),
                  badgeColor: Colors.yellow,
                  badgeContent: Text(
                    context.watch<Cart>().getItems.length.toString(),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  child: const Icon(Icons.shopping_cart)),
              // Icon(Icons.shopping_cart)

              label: 'Cart'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (value) {
          setState(() {
            widget.selectedIndex = value;
          });
        },
      ),
    );
  }
}
