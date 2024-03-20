// ignore_for_file: non_constant_identifier_names

import 'package:agritool/crop/crop_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CropWidget extends StatefulWidget {
  const CropWidget({super.key});

  @override
  State<CropWidget> createState() => _CropWidgetState();
}

List<String> plantation = [
  'coconut'.tr,
  'banana'.tr,
];
List<String> plantation_images = [
  'https://images.squarespace-cdn.com/content/v1/5c1074accc8fed6a4251da8f/1632825358284-7LGGMHZO98Q9L3FWUSKC/Coconut+Tree',
  'https://images.theconversation.com/files/227374/original/file-20180712-27021-7iamol.jpg?ixlib=rb-1.1.0&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip'
];
List<String> plantation_inner_images = [
  'https://facts.net/wp-content/uploads/2023/09/14-facts-about-coconut-1695067813.jpg',
  'https://fortmirrorprod.s3-ap-south-1.amazonaws.com/626532/healhTipsFolder/46811568789843023.jpg'
];
List<String> species = [
  'ginger'.tr,
  'blackpepper'.tr,
];
List<String> species_images = [
  'https://housing.com/news/wp-content/uploads/2022/11/ginger-plant-compressed.jpg',
  'https://www.thespruce.com/thmb/N6Bs_8HNcit_2mR6ye-42k_o8-A=/4000x0/filters:no_upscale():max_bytes(150000):strip_icc()/SPR-peppercorn-plant-profile-4584776-01-ef1e8aa3630d405f80f3a2cb746b9531.jpg'
];
List<String> species_inner_images = [
  'https://www.foodrepublic.com/img/gallery/fresh-ginger-is-the-key-to-aromatic-food-without-alliums/intro-1687368755.jpg',
  'https://www.thukralfoods.com/wp-content/uploads/2022/03/black-pepper-1.jpg'
];
List<String> medicinal = ['aloevera'.tr, 'basil'.tr];
List<String> medicinal_images = [
  'https://tiimg.tistatic.com/fp/1/006/460/aloe-vera-plants-and-fresh-leaf-611.jpg',
  'https://www.gaiaherbs.com/cdn/shop/articles/Holy-basil-header_copy_1199x.jpg?v=1592595554'
];
List<String> medicinal_inner_images = [
  'https://www.phyts.com/wp-content/uploads/2021/04/aloe-vera-scaled.jpg',
  'https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/topic_centers/Food-Nutrition/1296x728_Holy_Basil.jpg?w=1155&h=1528'
];
List<String> cereals = ['wheat'.tr, 'paddy'.tr];
List<String> cereals_images = [
  'https://lh3.googleusercontent.com/Me01z3pmDGKsESHg16WFGMp_7cWmLDPYtyHOXW5YpoDh5g3USUShnl57ep0giL5sSV-RrCu3Z5Nzak8WCcodvJblI352PZpkyR0g6eXDnoeqew=s750',
  'https://images.moneycontrol.com/static-mcnews/2022/08/sreehari-devadas-WDI95CIPW00-unsplash-770x433.jpg?impolicy=website&width=770&height=431'
];
List<String> cereals_inner_images = [
  'https://cdn.zeebiz.com/hindi/sites/default/files/styles/zeebiz_850x478/public/2023/03/16/129042-wheat.jpg',
  'https://www.crushpixel.com/big-static14/preview4/paddy-seeds-wooden-cup-white-1628202.jpg'
];
List<String> millets = ['ragi'.tr, 'bajra'.tr];
List<String> millets_images = [
  'https://t3.ftcdn.net/jpg/03/86/14/32/360_F_386143218_aujSBaM9BEac5yLUfnOWiqzfQ3PkZN90.jpg',
  'https://www.shutterstock.com/image-photo/millets-bajra-crop-fiels-farming-600nw-2349138427.jpg'
];
List<String> millets_inner_images = [
  'https://cdn.shopify.com/s/files/1/0624/0655/7914/files/Ragi-Finger-Millets_1024x1024.jpg?v=1678010268',
  'https://media.post.rvohealth.io/wp-content/uploads/2020/10/bajra-pearl-millet-grain-1200x628-facebook-1200x628.jpg'
];
List<String> fiber = ['jute'.tr, 'cotton'.tr];
List<String> fiber_images = [
  'https://t3.ftcdn.net/jpg/05/61/99/80/360_F_561998023_YmOc0Qe3VTK0o5uhJ9eH3BSX49z5dDVl.jpg',
  'https://today.tamu.edu/wp-content/uploads/2022/07/GettyImages-1320201171.jpg'
];
List<String> fiber_inner_images = [
  'https://d12oja0ew7x0i8.cloudfront.net/images/Article_Images/ImageForArticle_22090_16643686117593182.jpg',
  'https://img.freepik.com/premium-photo/cotton-plant-with-white-flowers-turquoise-blue-fabric_161301-4523.jpg'
];
List<String> cashcrops = ['sugarcane'.tr, 'tobacco'.tr];
List<String> cashcrops_images = [
  'https://miro.medium.com/v2/resize:fit:1400/1*brgt6gPYKhf3aGHjWjTnNg.png',
  'https://etimg.etb2bimg.com/photo/68196562.cms'
];
List<String> cashcrops_inner_images = [
  'https://www.saveur.com/uploads/2022/03/05/sugarcane-linda-xiao.jpg?auto=webp',
  'https://www.asianscientist.com/wp-content/uploads/bfi_thumb/tobacco-19997_1920-37om39fvb980ks5zxl9lvk.jpg'
];
List<String> fruits = [
  'mango'.tr,
  'guava'.tr,
  'apple'.tr,
  'pomegranate'.tr,
];

List<String> fruits_images = [
  'https://cdn.britannica.com/05/75905-050-C7AE0733/Mangoes-tree.jpg',
  'https://media.istockphoto.com/id/1065874500/photo/bunch-of-guava-fruits-in-a-tree-with-sunshine.jpg?s=612x612&w=0&k=20&c=sSu_mxwDxRzRU8LZ4fJHlz0VvK2HRpoU2hHLlbjcvJc=',
  'https://a-z-animals.com/media/2023/04/shutterstock_1798373137-2-1024x677.jpg',
  'https://i.etsystatic.com/25375239/r/il/e08ed3/3527106599/il_570xN.3527106599_c5xe.jpg'
];
List<String> fruits_inner_images = [
  'https://draxe.com/wp-content/uploads/2019/04/DrAxeMangoNutritionFB.jpg',
  'https://rukminim2.flixcart.com/image/850/1000/xif0q/plant-seed/x/l/v/45-guava-amrood-amrud-psidium-guajava-seeds-g1685-aywal-original-imagsy5zkcprhz96.jpeg?q=90',
  'https://aaharmarket.com/wp-content/uploads/2021/08/aahar_market_apple-1.jpeg',
  'https://images.herzindagi.info/image/2023/Feb/pomegranate-seeds-recipes.jpg'
];
List<String> trees = ['neem'.tr, 'eucalyptus'.tr, 'tamarind'.tr];
List<String> trees_images = [
  'https://media.post.rvohealth.io/wp-content/uploads/2021/05/neem-1200x628-facebook.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Eucalyptus_tereticornis_flowers%2C_capsules%2C_buds_and_foliage.jpeg/640px-Eucalyptus_tereticornis_flowers%2C_capsules%2C_buds_and_foliage.jpeg',
  'https://housing.com/news/wp-content/uploads/2023/01/Tamarind-tree-feature-compressed.jpg'
];
List<String> trees_inner_images = [
  'https://images.marico.in/uploads/img-0008-shutterstock-751429054-4730.jpg',
  'https://specialtyproduce.com/sppics/13238.png',
  'https://resize.indiatvnews.com/en/centered/newbucket/1200_675/2023/11/benefits-of-tamarind-1698810738.jpg'
];
List<String> vegetables = ['tomato'.tr, 'potato'.tr, 'carrot'.tr, 'onion'.tr];
List<String> vegetables_images = [
  'https://www.thespruce.com/thmb/aJMqntuaqHWnB1jIN2o5u9ZIYKY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/growing-tomatoes-1403296-01-e87fc6443b55423890448cabb12efeba.jpg',
  'https://www.epicgardening.com/wp-content/uploads/2023/05/potato-growth-stages.jpeg',
  'https://nationaltoday.com/wp-content/uploads/2021/04/Carrot-1200x834.jpg',
  'https://www.thespruce.com/thmb/FyEvqBhLbXlw0uWwLEherp4-XcQ=/5300x0/filters:no_upscale():max_bytes(150000):strip_icc()/growing-onions-1403447-01-38d480a2d16d4ea0b0dd174f42785e1d.jpg'
];
List<String> vegetables_inner_images = [
  'https://articles-1mg.gumlet.io/articles/wp-content/uploads/2018/05/tomatoes.jpg?compress=true&quality=80&w=640&dpr=2.6',
  'https://www.lovefoodhatewaste.com/sites/default/files/styles/open_graph_image/public/2022-08/Potatoes-shutterstock-1721688538.jpg?h=1dd3cf61&itok=VhB7fsyi',
  'https://dutable.com/wp-content/uploads/2019/03/1-131.jpg',
  'https://www.allthatgrows.in/cdn/shop/products/Onion-Red_1600x.jpg?v=1598081871'
];

class _CropWidgetState extends State<CropWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title('plantation'.tr),
        CustomGridView(plantation, plantation_images, plantation_inner_images),
        title('species'.tr),
        CustomGridView(species, species_images, species_inner_images),
        title('medicinal'.tr),
        CustomGridView(medicinal, medicinal_images, medicinal_inner_images),
        title('cereals'.tr),
        CustomGridView(cereals, cereals_images, cashcrops_inner_images),
        title('millets'.tr),
        CustomGridView(millets, millets_images, millets_inner_images),
        title('fibre'.tr),
        CustomGridView(fiber, fiber_images, fiber_inner_images),
        title('cashcrops'.tr),
        CustomGridView(cashcrops, cashcrops_images, cashcrops_inner_images),
        title('fruits'.tr),
        CustomGridView(fruits, fruits_images, fruits_inner_images),
        title('trees'.tr),
        CustomGridView(trees, trees_images, trees_inner_images),
        title('vegetables'.tr),
        CustomGridView(vegetables, vegetables_images, vegetables_inner_images),
      ],
    );
  }

  Widget title(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget CustomGridView(
      List<String> items, List<String> itemImages, List<String> innerImages) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 2, childAspectRatio: 1),
          itemBuilder: (_, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CropDetails(
                              item: items[index],
                              itemImages: innerImages[index],
                            )));
              },
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        height: 150,
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          itemImages[index],
                        ),
                      )
                      //  Image.network(
                      //   itemImages[index],
                      //   height: 150,
                      //   fit: BoxFit.cover,
                      // )
                      // child: CachedNetworkImage(
                      //   imageUrl:
                      //       'https://cdn.britannica.com/05/75905-050-C7AE0733/Mangoes-tree.jpg',
                      //   placeholder: (context, url) =>
                      //       CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),
                      ),
                  Text(items[index])
                ],
              ),
            );
          }),
    );
  }
}
