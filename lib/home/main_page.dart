import 'package:agritool/community/community.dart';
import 'package:agritool/community/make_post.dart';
import 'package:agritool/const/image_const.dart';
import 'package:agritool/crop/crop_practices.dart';
import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_icon.dart';
import 'package:agritool/custom/custom_icon_button.dart';
import 'package:agritool/custom/custom_navigation.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:agritool/home/home_page.dart';
import 'package:agritool/provider/auth_provider.dart';
import 'package:agritool/rental/rental_page.dart';
import 'package:agritool/shop/components/shop_page.dart';
import 'package:agritool/settings/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var ref = Provider.of<AuthProvider>(context);
    CustomSizeData size = CustomSizeData.from(context: context);
    double width = size.width;
    double height = size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            fontSize: size.largetext,
            fontWeight: FontWeight.bold,
            text: pageNo == 0
                ? "Agritool"
                : pageNo == 1
                    ? "Shop"
                    : pageNo == 3
                        ? "Crop Practices"
                        : pageNo == 2
                            ? 'Community'
                            : "Rental",
          ),
          actions: [
            pageNo == 0 || pageNo == 1
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CustomIconButton(
                          tooltip: 'Notifications',
                          onPressed: () {},
                          icon: const CustomIcon(icon: Icons.notifications),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CustomIconButton(
                            tooltip: 'Cart',
                            onPressed: () => context.push(const CartPage()),
                            icon: const CustomIcon(
                              icon: Icons.shopping_cart,
                            ),
                          )),
                    ],
                  )
                : pageNo == 2
                    ? GestureDetector(
                        onTap: () => context.push(const MakePost()),
                        child: const Row(
                          children: [
                            CustomText(
                              text: 'Create post',
                            ),
                            CustomIcon(
                              icon: Icons.add,
                            ),
                          ],
                        ),
                      )
                    : CustomIconButton(
                        onPressed: () {},
                        icon: const CustomIcon(
                          icon: Icons.search,
                        ),
                      )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              GestureDetector(
                onTap: () => context.push(const SettingPage()),
                child: DrawerHeader(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: width * 0.1,
                          backgroundImage:
                              const AssetImage(ImageConst.avatarImage),
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Harisharajan"),
                          CustomText(text: "9791340230"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomText(
                  text: "Account",
                  fontSize: size.smalltext,
                ),
              ),
              drawerelements('My Orders', 0),
              drawerelements('My Addresses', 1),
              drawerelements('Disease Detection', 6),
              Divider(
                height: height * 0.008,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text("Feedback and Information"),
              ),
              drawerelements('Contact Us', 2),
              drawerelements('About', 3),
              drawerelements('Share App', 4),
              drawerelements('Rate App', 5),
              Divider(
                height: height * 0.008,
              ),
              ListTile(
                title: const CustomText(text: 'Logout'),
                selected: _selectedIndex == 2,
                onTap: () {
                  ref.userSignOut().then((value) => context.pop());
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              pageNo == 0 || pageNo == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: GestureDetector(
                        onTap: () {
                          // showSearch(
                          //     context: context,
                          //     delegate: CustomSearchDelegate());
                        },
                        child: Container(
                          height: height * 0.055,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: CustomText(text: 'Search Product here'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: CustomIcon(
                                  icon: Icons.search,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              pageNo == 0
                  ? const HomeWidget()
                  : pageNo == 1
                      ? const ShopWidget()
                      : pageNo == 2
                          ? const CommunityScreen()
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
                  CustomIconButton(
                    onPressed: () {
                      setState(() {
                        pageNo = 2;
                      });
                    },
                    icon: const CustomIcon(
                      icon: Icons.add_circle_outline_outlined,
                      size: 40,
                    ),
                  ),
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
      children: [
        CustomIcon(
          icon: icon,
        ),
        CustomText(
          text: text,
        ),
      ],
    );
  }

  Widget drawerelements(String text, int index) {
    return ListTile(
      title: CustomText(text: text),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);
        context.pop();
      },
    );
  }
}
