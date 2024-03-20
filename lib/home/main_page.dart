import 'package:agritool/community/blog_page.dart';
import 'package:agritool/crop/crop_practices.dart';
import 'package:agritool/home/home_page.dart';
import 'package:agritool/rental/rental_page.dart';
import 'package:agritool/shop/components/shop_page.dart';
import 'package:agritool/search/searching.dart';
import 'package:agritool/settings/setting_page.dart';
import 'package:flutter/material.dart';

import '../shop/components/cart_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int pageNo = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(pageNo == 0
                ? "Agritool"
                : pageNo == 1
                    ? "Shop"
                    : pageNo == 3
                        ? "Crop Practices"
                        : "Rental"),
            actions: [
              pageNo == 0 || pageNo == 1
                  ? Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: IconButton(
                                tooltip: 'Notifications',
                                onPressed: () {},
                                icon: const Icon(Icons.notifications))),
                        Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.shopping_cart),
                            )),
                      ],
                    )
                  : IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ]),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingPage()));
                },
                child: const DrawerHeader(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Harisharajan"),
                          Text("9791340230"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Account"),
              ),
              drawerelements('My Orders', 0),
              drawerelements('My Addresses', 1),
              drawerelements('Disease Detection', 6),
              const Divider(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Feedback and Information"),
              ),
              drawerelements('Contact Us', 2),
              drawerelements('About', 3),
              drawerelements('Share App', 4),
              drawerelements('Rate App', 5),
              const Divider(
                height: 10,
              ),
              ListTile(
                title: const Text('Logout'),
                selected: _selectedIndex == 2,
                onTap: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              pageNo == 0 || pageNo == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: GestureDetector(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate());
                        },
                        child: Container(
                          height: 55,
                          // ignore: sort_child_properties_last
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Search Product here'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.search),
                              )
                            ],
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    )
                  : const SizedBox(),
              pageNo == 0
                  ? const HomeWidget()
                  : pageNo == 1
                      ? const ShopWidget()
                      : pageNo == 2
                          ? const BlogPage()
                          : pageNo == 3
                              ? const CropWidget()
                            
                              : const RentalPage()
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    pageNo = 0;
                  });
                },
                child: naviagationelements(
                  'Home',
                  Icons.home,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      pageNo = 1;
                    });
                  },
                  child: naviagationelements('Shop', Icons.shop)),
              Column(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          pageNo = 2;
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_outlined,
                        size: 40,
                      )),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    pageNo = 3;
                  });
                },
                child: naviagationelements(
                  'Crop',
                  Icons.description_outlined,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    pageNo = 4;
                  });
                },
                child: naviagationelements(
                  'Rental',
                  Icons.car_rental,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget naviagationelements(
    String text,
    IconData icon,
  ) {
    return Column(
      children: [Icon(icon), Text(text)],
    );
  }

  Widget drawerelements(String text, int index) {
    return ListTile(
      title: Text(text),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);

        Navigator.pop(context);
      },
    );
  }
}
