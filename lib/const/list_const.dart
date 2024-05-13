import 'package:agritool/calculator/choose_crop.dart';
import 'package:agritool/commodity/commodityPage.dart';
import 'package:agritool/lifesaver/lifesaver.dart';
import 'package:agritool/news/pages/new_pages.dart';
import 'package:flutter/material.dart';

class ListContants {
  // HomePage items
  static const List homeItems = [
    [
      "Popular News",
      NewsPage(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fnews.png?alt=media&token=e3c456f5-c018-4c82-8599-e3f5177bdbe2",
      Colors.green
    ],
    [
      "Disease detection",
      NewsPage(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fscanner.png?alt=media&token=46886fbd-8e0a-4b1c-8896-957d6c88d10d",
      Colors.yellow,
    ],
    [
      "Commodity Price",
      CommodityPage(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fmarket_price.png?alt=media&token=d443555a-7474-4402-bafb-f6019c402ecb",
      Colors.brown
    ],
    [
      "Fertilizer Calculator",
      ChooseFertilizerCalculator(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fcalculator.png?alt=media&token=62c5e466-48d2-4e77-8a8e-d3db004a5e07",
      Colors.blue
    ],
    [
      "Life saver",
      LifeSaver(),
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/homepage%2Fcalculator.png?alt=media&token=62c5e466-48d2-4e77-8a8e-d3db004a5e07",
      Colors.purple
    ],
  ];

// Shopping Items
  static const List shopItems = [
    // [itemName, itemPrice, imagePath, color],
    [
      "Tomato",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftomato.png?alt=media&token=34a631ab-3d6a-49df-a8f5-6ab1329477eb",
    ],
    [
      "Potato",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpotato.png?alt=media&token=7b1f5aa0-aa96-4bab-b5fa-5c07cc6d2af7",
    ],
    [
      "Carrot",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcarrot.png?alt=media&token=a79fc8d7-8d0d-4af9-b2c9-47956f6700a5",
    ],
    [
      "Onion",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fonion.png?alt=media&token=00f099e7-3046-4f08-8671-d816d22efd8a",
    ],
    [
      "Brinjal",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbrinjal.png?alt=media&token=7401ac19-9c3e-4167-8eae-fb6d7158f93e"
    ],
    [
      "Drumstick",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fdrumstick.png?alt=media&token=550273c1-4ffb-4aaf-b686-0e1b8602fc6a"
    ],
    [
      "Garlic",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgarlic.png?alt=media&token=af0fbdaf-0b37-4821-8b95-eec6ff16bac8"
    ],
    [
      "Beans",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbeans.png?alt=media&token=2f8fd7e6-81e9-4b45-b83c-395b729a0cbe"
    ],
    [
      "Ginger",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fginger.png?alt=media&token=ace5f7f7-d8dc-4e51-aed9-99a62593be85"
    ],
    [
      "Tamarind",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftamarind.png?alt=media&token=a8a9e56e-5466-4102-b54e-73d54b3494ce"
    ],
    [
      "Lady's finger",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fladys%20finger.png?alt=media&token=2321daa8-bf07-4228-b7b7-98d0ca43eeaa"
    ],
    [
      "Coconut",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcoconut.png?alt=media&token=6e9b9066-5ec9-46ea-a865-5a8506af2cdb"
    ],
    [
      "Mango",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fmango.png?alt=media&token=48872370-f892-48a9-b76a-f6cfe2937743",
    ],
    [
      "Guava",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fguava.png?alt=media&token=e2947cca-f369-4c8a-88c0-32fdc2addb52"
    ],
    [
      "Apple",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fapple.png?alt=media&token=12f8638c-6794-4b49-a6a8-ae40c2951baf"
    ],
    [
      "Pomegranate",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpomegranate.png?alt=media&token=68a844cf-58ea-4eb5-a64d-3fbcd1ecdf43"
    ],
    [
      "Banana",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbanana.png?alt=media&token=44355a44-2441-4015-a78d-f88c815077ac"
    ],
    [
      "Orange",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Forange.png?alt=media&token=d8fee31e-b1d4-4e37-ab51-d1945f347b9a"
    ],
    [
      "Grape",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgrape.png?alt=media&token=0c7dd27c-12bf-40af-ab78-dce3e8f5aa39"
    ],
    [
      "Paddy",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpaddy.png?alt=media&token=17bae812-52ef-4b22-bf0b-b28e74f72082"
    ],
    [
      "Wheat",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fwheat.png?alt=media&token=0117b69a-f2ca-433d-9019-f0fa21f9e772"
    ],
    [
      "Ragi",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fragi.png?alt=media&token=ee623098-6897-43ea-8151-538739f5366b"
    ],
    [
      "Kambu",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fkambu.png?alt=media&token=6bdbe4db-bcb0-4c30-a6bc-020d5b8c40fe"
    ]
  ];

  // Life Saver Constants
  static const List<String> seedDonationTitle = [
    'Seed Sovereignty Movement (SSM)',
    'MSSRF (M.S. Swaminathan Research Foundation):',
    'Tamil Nadu Organic Farmers Association (TOFA):',
    'Seeds Trust:',
    'Dhan Foundation:',
    'Vanagam:',
    'Association for Rural Women\'s Development (ARWD):',
    'Aadhimalai Pazhangudiyinar Producer Company Limited (APPC):'
  ];

  static const List<String> plantDonationTitle = [
    'Vanashree Agroforestry Development Centre:',
    'Nizhal Urban Tree Conservation Group:',
    'Aranya Environmental Organization:',
    'Sadhana Forest:',
    'Tamil Nadu Green Movement:',
    'The Banyan:',
    'Youth for Social Change:',
    'Ainthinai:'
// These NGOs vary in their specific focus areas and activities, but they all contribute to environmental conservation, tree planting, and greening efforts in Tamil Nadu.
  ];
  static const List<String> plantDonationDescription = [
    'This organization focuses on agroforestry and tree planting initiatives in Tamil Nadu, including distributing saplings to farmers and communities.',
    'Nizhal works on urban tree conservation and greening initiatives in Chennai and other urban areas of Tamil Nadu. They organize tree planting drives and may provide saplings to interested individuals and organizations.',
    'Aranya works on environmental conservation and sustainable development in Tamil Nadu, including tree planting and afforestation projects. They may donate saplings for community-based initiatives.',
    'Although primarily based in Auroville, Sadhana Forest also conducts tree planting projects and afforestation efforts in Tamil Nadu. They may donate saplings for reforestation and conservation projects.',
    'This organization focuses on environmental awareness and conservation efforts in Tamil Nadu. They may support tree planting initiatives and provide saplings for distribution.',
    'While not primarily focused on tree planting, The Banyan is a Chennai-based NGO that works on mental health and social inclusion. They may occasionally organize tree planting events as part of their community engagement activities.',
    'This youth-led organization in Tamil Nadu works on various social and environmental issues, including tree planting and environmental conservation projects. They may donate saplings for community-based initiatives.',
    'Ainthinai, meaning "sapling" in Tamil, is a Chennai-based group that focuses on tree planting, urban greening, and environmental awareness. They conduct tree planting drives and may provide saplings for distribution to individuals and organizations.',
  ];
  static const List<String> seedDonationDescription = [
    'SSM works to promote seed sovereignty, sustainable agriculture, and farmer autonomy. They often distribute indigenous and traditional seeds to farmers in Tamil Nadu.',
    'MSSRF, founded by renowned agricultural scientist M.S. Swaminathan, works on various aspects of sustainable agriculture and rural development in Tamil Nadu, including seed distribution programs.',
    'TOFA promotes organic farming practices and seed sovereignty in Tamil Nadu. They often organize seed fairs and distribution events.',
    'Seeds Trust is a non-profit organization dedicated to preserving and distributing heirloom seeds. While not based in Tamil Nadu, they may have partners or affiliates in the region who distribute seeds.',
    'Dhan Foundation works on various development initiatives in Tamil Nadu, including agriculture and livelihoods. They may occasionally distribute seeds to farmers in need.',
    'Vanagam focuses on sustainable agriculture and biodiversity conservation in Tamil Nadu. They may provide seeds and training to farmers interested in organic and traditional farming practices.',
    ' ARWD works on women\'s empowerment and sustainable livelihoods in rural Tamil Nadu. They may support seed distribution initiatives targeted at women farmers.',
    'Aadhimalai Pazhangudiyinar Producer Company Limited (APPC): APPC is a producer company that works with tribal communities in the Nilgiris district of Tamil Nadu. They may be involved in seed distribution programs tailored to tribal farmers.',
  ];

  // CartModel
  static const List shoppingItemsCost = [
    // [itemName, itemPrice, imagePath, color],
    [
      "Tomato",
      "40",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftomato.png?alt=media&token=34a631ab-3d6a-49df-a8f5-6ab1329477eb",
      Colors.green
    ],
    [
      "Potato",
      "50",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpotato.png?alt=media&token=7b1f5aa0-aa96-4bab-b5fa-5c07cc6d2af7",
      Colors.green
    ],
    [
      "Carrot",
      "60",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcarrot.png?alt=media&token=a79fc8d7-8d0d-4af9-b2c9-47956f6700a5",
      Colors.green
    ],
    [
      "Onion",
      "30",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fonion.png?alt=media&token=00f099e7-3046-4f08-8671-d816d22efd8a",
      Colors.green
    ],
    [
      "Brinjal",
      "63",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbrinjal.png?alt=media&token=7401ac19-9c3e-4167-8eae-fb6d7158f93e",
      Colors.green
    ],
    [
      "Drumstick",
      "120",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fdrumstick.png?alt=media&token=550273c1-4ffb-4aaf-b686-0e1b8602fc6a",
      Colors.green
    ],
    [
      "Garlic",
      "180",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgarlic.png?alt=media&token=af0fbdaf-0b37-4821-8b95-eec6ff16bac8",
      Colors.green
    ],
    [
      "Beans",
      "30",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbeans.png?alt=media&token=2f8fd7e6-81e9-4b45-b83c-395b729a0cbe",
      Colors.green
    ],
    [
      "Ginger",
      "220",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fginger.png?alt=media&token=ace5f7f7-d8dc-4e51-aed9-99a62593be85",
      Colors.green
    ],
    [
      "Tamarind",
      "200",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Ftamarind.png?alt=media&token=a8a9e56e-5466-4102-b54e-73d54b3494ce",
      Colors.green
    ],
    [
      "Lady's finger",
      "35",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fladys%20finger.png?alt=media&token=2321daa8-bf07-4228-b7b7-98d0ca43eeaa",
      Colors.green
    ],
    [
      "Coconut",
      "25",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fcoconut.png?alt=media&token=6e9b9066-5ec9-46ea-a865-5a8506af2cdb",
      Colors.green
    ],
    [
      "Mango",
      "70",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fmango.png?alt=media&token=48872370-f892-48a9-b76a-f6cfe2937743",
      Colors.green
    ],
    [
      "Guava",
      "80",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fguava.png?alt=media&token=e2947cca-f369-4c8a-88c0-32fdc2addb52",
      Colors.green
    ],
    [
      "Apple",
      "250",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fapple.png?alt=media&token=12f8638c-6794-4b49-a6a8-ae40c2951baf",
      Colors.green
    ],
    [
      "Pomegranate",
      "150",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpomegranate.png?alt=media&token=68a844cf-58ea-4eb5-a64d-3fbcd1ecdf43",
      Colors.green
    ],
    [
      "Banana",
      "55",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fbanana.png?alt=media&token=44355a44-2441-4015-a78d-f88c815077ac",
      Colors.green
    ],
    [
      "Orange",
      "120",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Forange.png?alt=media&token=d8fee31e-b1d4-4e37-ab51-d1945f347b9a",
      Colors.green
    ],
    [
      "Grape",
      "80",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fgrape.png?alt=media&token=0c7dd27c-12bf-40af-ab78-dce3e8f5aa39",
      Colors.green
    ],
    [
      "Paddy",
      "62",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fpaddy.png?alt=media&token=17bae812-52ef-4b22-bf0b-b28e74f72082",
      Colors.green
    ],
    [
      "Wheat",
      "145",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fwheat.png?alt=media&token=0117b69a-f2ca-433d-9019-f0fa21f9e772",
      Colors.green
    ],
    [
      "Ragi",
      "135",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fragi.png?alt=media&token=ee623098-6897-43ea-8151-538739f5366b",
      Colors.green
    ],
    [
      "Kambu",
      "168",
      "https://firebasestorage.googleapis.com/v0/b/agritool-591f8.appspot.com/o/shopitems%2Fkambu.png?alt=media&token=6bdbe4db-bcb0-4c30-a6bc-020d5b8c40fe",
      Colors.green
    ]
  ];
}
