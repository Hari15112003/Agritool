import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LifeSaver extends StatefulWidget {
  const LifeSaver({super.key});

  @override
  State<LifeSaver> createState() => _LifeSaverState();
}

class _LifeSaverState extends State<LifeSaver> {
  List<String> seedDonationTitle = const [
    'Seed Sovereignty Movement (SSM)',
    'MSSRF (M.S. Swaminathan Research Foundation):',
    'Tamil Nadu Organic Farmers Association (TOFA):',
    'Seeds Trust:',
    'Dhan Foundation:',
    'Vanagam:',
    'Association for Rural Women\'s Development (ARWD):',
    'Aadhimalai Pazhangudiyinar Producer Company Limited (APPC):'
  ];

  List<String> plantDonationTitle = const [
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
  List<String> plantDonationDescription = const [
    'This organization focuses on agroforestry and tree planting initiatives in Tamil Nadu, including distributing saplings to farmers and communities.',
    'Nizhal works on urban tree conservation and greening initiatives in Chennai and other urban areas of Tamil Nadu. They organize tree planting drives and may provide saplings to interested individuals and organizations.',
    'Aranya works on environmental conservation and sustainable development in Tamil Nadu, including tree planting and afforestation projects. They may donate saplings for community-based initiatives.',
    'Although primarily based in Auroville, Sadhana Forest also conducts tree planting projects and afforestation efforts in Tamil Nadu. They may donate saplings for reforestation and conservation projects.',
    'This organization focuses on environmental awareness and conservation efforts in Tamil Nadu. They may support tree planting initiatives and provide saplings for distribution.',
    'While not primarily focused on tree planting, The Banyan is a Chennai-based NGO that works on mental health and social inclusion. They may occasionally organize tree planting events as part of their community engagement activities.',
    'This youth-led organization in Tamil Nadu works on various social and environmental issues, including tree planting and environmental conservation projects. They may donate saplings for community-based initiatives.',
    'Ainthinai, meaning "sapling" in Tamil, is a Chennai-based group that focuses on tree planting, urban greening, and environmental awareness. They conduct tree planting drives and may provide saplings for distribution to individuals and organizations.',
  ];
  List<String> seedDonationDescription = const [
    'SSM works to promote seed sovereignty, sustainable agriculture, and farmer autonomy. They often distribute indigenous and traditional seeds to farmers in Tamil Nadu.',
    'MSSRF, founded by renowned agricultural scientist M.S. Swaminathan, works on various aspects of sustainable agriculture and rural development in Tamil Nadu, including seed distribution programs.',
    'TOFA promotes organic farming practices and seed sovereignty in Tamil Nadu. They often organize seed fairs and distribution events.',
    'Seeds Trust is a non-profit organization dedicated to preserving and distributing heirloom seeds. While not based in Tamil Nadu, they may have partners or affiliates in the region who distribute seeds.',
    'Dhan Foundation works on various development initiatives in Tamil Nadu, including agriculture and livelihoods. They may occasionally distribute seeds to farmers in need.',
    'Vanagam focuses on sustainable agriculture and biodiversity conservation in Tamil Nadu. They may provide seeds and training to farmers interested in organic and traditional farming practices.',
    ' ARWD works on women\'s empowerment and sustainable livelihoods in rural Tamil Nadu. They may support seed distribution initiatives targeted at women farmers.',
    'Aadhimalai Pazhangudiyinar Producer Company Limited (APPC): APPC is a producer company that works with tribal communities in the Nilgiris district of Tamil Nadu. They may be involved in seed distribution programs tailored to tribal farmers.',
  ];

// These NGOs vary in their specific focus areas, but they all contribute to promoting sustainable agriculture, seed sovereignty, and rural development in Tamil Nadu.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Text(
                      "Life Saver",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              Text("Seed Donation"),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: seedDonationTitle.length,
                  itemBuilder: (build, index) {
                    return ExpansionTile(
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      title: Text(seedDonationTitle[index]),
                      children: [
                        Text(
                          seedDonationDescription[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Text("Plant Donation"),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: plantDonationTitle.length,
                  itemBuilder: (build, index) {
                    return ExpansionTile(
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      title: Text(plantDonationTitle[index]),
                      children: [
                        Text(
                          plantDonationDescription[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
